class Notebook < ApplicationRecord
  has_many :headings, dependent: :destroy
end
