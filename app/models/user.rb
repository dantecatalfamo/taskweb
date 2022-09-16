class User < ApplicationRecord
  has_many :notebooks, dependent: :destroy
  has_many :headings, dependent: :destroy
  has_many :heading_states, dependent: :destroy
  validates :username, presence: true

  has_secure_password
end
