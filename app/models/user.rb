class User < ApplicationRecord
  has_many :notebooks
  validates :username, presence: true

  has_secure_password
end
