class User < ApplicationRecord
  has_many :notebooks
  has_many :headings
  has_many :heading_states
  validates :username, presence: true

  has_secure_password
end
