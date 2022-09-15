class Notebook < ApplicationRecord
  has_many :headings, dependent: :destroy
  belongs_to :user
end
