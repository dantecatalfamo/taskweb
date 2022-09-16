require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'user login' do
    get notebooks_path
    assert_response :redirect
    post login_url, params: { login: { username: users(:one).username, password: 'secret' } }
    get notebooks_path
    assert_response :success
  end

  test 'user logout' do
    post login_url, params: { login: { username: users(:one).username, password: 'secret' } }
    get notebooks_path
    assert_response :success
    delete logout_path
    get notebooks_path
    assert_response :redirect
  end
end
