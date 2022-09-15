class User < ApplicationRecord
  has_many :notebooks
  has_many :headings
  validates :username, presence: true

  has_secure_password
end
