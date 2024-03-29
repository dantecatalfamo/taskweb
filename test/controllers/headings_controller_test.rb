require 'test_helper'

class HeadingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heading = headings(:three)
    post login_url, params: { login: { username: users(:one).username, password: 'secret' } }
  end

  # No index for headings
  # test 'should get index' do
  #   get headings_url
  #   assert_response :success
  # end

  test 'should get new' do
    get new_heading_url
    assert_response :success
  end

  test 'should create heading' do
    assert_difference('Heading.count') do
      post headings_url,
           params: { heading: { body: @heading.body, deadline: @heading.deadline, scheduled: @heading.scheduled,
                                state: @heading.state, title: @heading.title, notebook_id: notebooks(:one).id } }
    end

    assert_redirected_to notebook_url(@heading.notebook)
  end

  test 'should show heading' do
    get heading_url(@heading)
    assert_response :success
  end

  test 'should get edit' do
    get edit_heading_url(@heading)
    assert_response :success
  end

  test 'should update heading' do
    patch heading_url(@heading),
          params: { heading: { body: @heading.body, deadline: @heading.deadline, scheduled: @heading.scheduled,
                               state: @heading.state, title: @heading.title } }
    assert_redirected_to heading_url(@heading)
  end

  test 'should destroy heading' do
    assert_difference('Heading.count', -1) do
      delete heading_url(@heading)
    end

    assert_redirected_to headings_url
  end

  test 'should get agenda' do
    get agenda_url
    assert_response :success
  end

  test 'should get agenda json' do
    get agenda_url(format: :json)
    assert_response :success
  end

  test 'sould get heading json' do
    get heading_url(@heading)
    assert_response :success
  end

  test 'should get headings index json' do
    get headings_url(format: :json)
    assert_response :success
  end

  test 'should get heading org' do
    get heading_url(@heading)
    assert_response :success
  end

  test 'should get heading by org id' do
    get heading_url(headings(:one).org_id)
    assert_response :success
  end

  # No index for headings
  # test 'should get headings index org' do
  #   get headings_url(format: :org)
  #   assert_response :success
  # end
end
