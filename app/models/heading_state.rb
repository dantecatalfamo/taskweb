class HeadingState < ApplicationRecord
  belongs_to :user
  has_many :headings
end
