class Heading < ApplicationRecord
  belongs_to :parent, class_name: 'Heading', foreign_key: :parent_id, required: false, counter_cache: true
  belongs_to :state, class_name: 'HeadingState', foreign_key: :heading_state_id, required: false
  has_many :children, class_name: 'Heading', foreign_key: :parent_id, dependent: :destroy

  before_save :set_depth
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
  scope :dates_not_done, -> { dates.not_todo_or_done }

  def dates?
    !!(deadline || scheduled)
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
