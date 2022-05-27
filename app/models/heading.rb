class Heading < ApplicationRecord
  belongs_to :parent, class_name: 'Heading', foreign_key: :parent_id, required: false
  has_many :headings, class_name: 'Heading', foreign_key: :parent_id, dependent: :destroy

  scope :top_level, -> { where(parent: nil) }

  def depth
    if parent.nil?
      return 1
    else
      return 1 + parent.depth
    end
  end
end
