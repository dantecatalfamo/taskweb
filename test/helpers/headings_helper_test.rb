require "test_helper"

class HeadingsHelperTest < ActionView::TestCase
  test "should render org deadline correctly" do
    deadline = deadline_scheduled_line(headings(:one))

    assert_equal deadline, "DEADLINE: <2022-05-27 Fri 10:44>"
  end

  test "should render org schedule correctly" do
    scheduled = deadline_scheduled_line(headings(:two))

    assert_equal scheduled, "SCHEDULED: <2022-05-27 Fri 10:44>"
  end

  test "should render org schedule and deadline correctly" do
    line = deadline_scheduled_line(headings(:three))

    assert_equal line, "DEADLINE: <2022-05-27 Fri 10:44> SCHEDULED: <2022-05-27 Fri 10:44>"
  end
end
