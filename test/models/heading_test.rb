require 'test_helper'

class HeadingTest < ActiveSupport::TestCase
  test 'should check if a heading has a date' do
    assert headings(:one).dates?
    assert_not headings(:four).dates?
  end

  test 'should create empty heading' do
    assert Heading.new(notebook_id: notebooks(:one).id, user: users(:one)).save
  end

  test 'should set closed_at properly' do
    heading = Heading.new(notebook_id: notebooks(:one).id, heading_state_id: heading_states(:todo), user: users(:one))
    heading.save!
    assert_not heading.closed_at
    heading.state = heading_states(:done)
    heading.save!
    assert heading.closed_at
    heading.state = heading_states(:todo)
    heading.save!
    assert_not heading.closed_at
    heading.state = nil
    heading.save!
    assert_not heading.closed_at
    heading.state = heading_states(:done)
    heading.save!
    assert heading.closed_at
  end
end
