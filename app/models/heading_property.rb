class HeadingProperty < ApplicationRecord
  belongs_to :heading, touch: true

  before_save :upcase_key

  def upcase_key
    key.upcase!
  end
end
