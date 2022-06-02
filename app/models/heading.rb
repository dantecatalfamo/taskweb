class Heading < ApplicationRecord
  belongs_to :parent, class_name: 'Heading', foreign_key: :parent_id, required: false, counter_cache: true
  has_many :headings, class_name: 'Heading', foreign_key: :parent_id, dependent: :destroy

  before_save :set_depth
  after_save :fix_children_depth

  scope :top_level, -> { where(parent: nil) }

  def dates?
    !!(deadline || scheduled)
  end

  protected

  def fix_children_depth
    return unless saved_change_to_depth? || saved_change_to_parent_id?

    headings.each do |child|
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
