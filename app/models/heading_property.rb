class HeadingProperty < ApplicationRecord
  belongs_to :heading, touch: true
  belongs_to :user

  before_save :upcase_key

  def upcase_key
    key.upcase!
  end
end
