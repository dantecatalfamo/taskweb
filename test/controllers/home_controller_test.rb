require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get home_url
    assert_response :success
  end

  test 'should show notebooks' do
    get home_url

    assert_select '#notebooks' do
      assert_select "\##{dom_id notebooks(:one)}" do
        assert_select 'a', notebooks(:one).title
      end
    end
  end

  test 'should show agenda' do
    get home_url

    assert_select '#agenda' do
      assert_select '#agenda-dates' do
        assert_select 'li span', HeadingsController.helpers.agenda_date(Date.today)
      end
    end
  end
end
