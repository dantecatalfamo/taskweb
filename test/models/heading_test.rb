require 'test_helper'

class HeadingTest < ActiveSupport::TestCase
  test 'should check if a heading has a date' do
    assert headings(:one).dates?
    assert_not headings(:four).dates?
  end

  test 'should create empty heading' do
    assert Heading.new(notebook_id: notebooks(:one).id).save
  end
end
