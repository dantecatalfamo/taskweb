class HeadingProperty < ApplicationRecord
  belongs_to :heading

  before_save :upcase_key

  def upcase_key
    key.upcase!
  end
end
