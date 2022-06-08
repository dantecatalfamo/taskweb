require "test_helper"

class HeadingTest < ActiveSupport::TestCase
  test "should check if a heading has a date" do
    assert headings(:one).dates?
    assert_not headings(:four).dates?
  end
end
