require 'test_helper'

class HeadingStatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heading_state = heading_states(:todo)
    post login_url, params: { login: { username: users(:one).username, password: 'secret' } }
  end

  test 'should get index' do
    get heading_states_url
    assert_response :success
  end

  test 'should get new' do
    get new_heading_state_url
    assert_response :success
  end

  test 'should create heading_state' do
    assert_difference('HeadingState.count') do
      post heading_states_url, params: { heading_state: { done: @heading_state.done, name: @heading_state.name } }
    end

    assert_redirected_to heading_states_url
  end

  test 'should show heading_state' do
    get heading_state_url(@heading_state)
    assert_response :success
  end

  test 'should get edit' do
    get edit_heading_state_url(@heading_state)
    assert_response :success
  end

  test 'should update heading_state' do
    patch heading_state_url(@heading_state),
          params: { heading_state: { done: @heading_state.done, name: @heading_state.name } }
    assert_redirected_to heading_states_url
  end

  test 'should destroy heading_state' do
    assert_difference('HeadingState.count', -1) do
      delete heading_state_url(@heading_state)
    end

    assert_redirected_to heading_states_url
  end
end
