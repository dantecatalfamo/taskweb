class Heading < ApplicationRecord
  belongs_to :parent, class_name: 'Heading', foreign_key: :parent_id, required: false, counter_cache: true
  belongs_to :state, class_name: 'HeadingState', foreign_key: :heading_state_id, required: false
  belongs_to :notebook
  belongs_to :user
  has_many :children, class_name: 'Heading', foreign_key: :parent_id, dependent: :destroy

  before_save :set_depth
  before_save :set_closed_at, if: :will_save_change_to_heading_state_id?
  after_save :fix_children_depth

  scope :top_level,  -> { where(parent: nil) }
  scope :deadlines,  -> { where.not(deadline: nil) }
  scope :schedules,  -> { where.not(scheduled: nil) }
  scope :dates,      -> { where.not(deadline: nil).or(where.not(scheduled: nil)) }
  scope :done,       -> { joins(:state).where(state: { done: true }) }
  scope :not_done,   -> { joins(:state).where(state: { done: false }) }
  scope :todo,       -> { where.not(state: nil) }
  scope :not_todo,   -> { where(state: nil) }
  scope :not_todo_or_done, -> { left_joins(:state).where(state: nil).or(where(state: { done: false })) }
  scope :dates_not_done,   -> { dates.not_todo_or_done }
  scope :dates_until,      ->(end_date) { where(deadline: ..end_date).or(where(scheduled: ..end_date)) }
  scope :dates_between,    ->(start_date, end_date) { where(deadline: start_date..end_date).or(where(scheduled: start_date..end_date)) }

  DateHeadings = Struct.new(:date, :headings)

  def self.agenda_dates(end_date = 2.weeks.from_now)
    headings = dates_until(end_date).not_todo_or_done
    days = (DateTime.now..end_date).to_a
    headings_by_date = days.map do |day|
      day_headings = headings.filter do |heading|
        heading.deadline&.to_date == day.to_date || heading.scheduled&.to_date == day.to_date
      end
      DateHeadings.new(day.to_date, day_headings)
    end
    overdue = headings.filter do |heading|
      heading.deadline&.to_date&.<(days.first.to_date) || heading.scheduled&.to_date&.<(days.first.to_date)
    end
    headings_by_date.first.headings.unshift(*overdue)
    headings_by_date
  end

  def dates?
    !!(deadline || scheduled)
  end

  def dateline?
    dates? || !!closed_at
  end

  def set_closed_at
    old_state = HeadingState.find_by(id: heading_state_id_was)

    if !state&.done
      self.closed_at = nil
    elsif state&.done && !old_state&.done
      self.closed_at = Time.now
    end
  end

  protected

  def fix_children_depth
    return unless saved_change_to_depth? || saved_change_to_parent_id?

    children.each do |child|
      next unless child.depth != depth + 1

      child.depth = depth + 1
      child.save!
      child.fix_children_depth
    end
  end

  private

  def set_depth
    self.depth = if parent.nil?
                   1
                 else
                   1 + parent.depth
                 end
  end
end
