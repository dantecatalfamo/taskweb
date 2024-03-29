require 'test_helper'

class HeadingsHelperTest < ActionView::TestCase
  MARKUP_SPEC = [
    { verb: 'bolden',    tag: 'strong', mark: '*' },
    { verb: 'italicize', tag: 'em',     mark: '/' },
    { verb: 'underline', tag: 'ins',    mark: '_' },
    { verb: 'strike',    tag: 'del',    mark: '+' },
    { verb: 'code',      tag: 'code',   mark: '~' },
    { verb: 'vermatim',  tag: 'samp',   mark: '=' }
  ]

  test 'should render org deadline correctly' do
    deadline = deadline_scheduled_line(headings(:one))

    assert_equal 'DEADLINE: <2022-05-27 Fri 06:44>', deadline
  end

  test 'should render org schedule correctly' do
    scheduled = deadline_scheduled_line(headings(:two))

    assert_equal 'SCHEDULED: <2022-05-27 Fri 06:44>', scheduled
  end

  test 'should render org schedule and deadline correctly' do
    line = deadline_scheduled_line(headings(:three))

    assert_equal 'DEADLINE: <2022-05-27 Fri 06:44> SCHEDULED: <2022-05-27 Fri 06:44>', line
  end

  test 'should render closed_at correctly' do
    line = deadline_scheduled_line(headings(:four))

    assert_equal 'CLOSED: [2022-05-27 Fri 06:44]', line
  end

  test 'should put a source block in code tags' do
    line = process_org_body(headings(:src_block).body)

    assert_match('pre', line)
    assert_match('code', line)
  end

  test 'should replace org link with html link' do
    line = process_org_body(headings(:org_link).body)

    assert_match(/<a href=\.*/, line)
  end

  test 'should return the correct number of stars' do
    assert_equal '*****', stars(5)
  end

  MARKUP_SPEC.each do |spec|
    test "should #{spec[:verb]} text" do
      assert_match(spec[:tag], process_org_body("#{spec[:mark]}testing#{spec[:mark]}"))
    end
  end
end
