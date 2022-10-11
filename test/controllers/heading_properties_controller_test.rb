require "test_helper"

class HeadingPropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heading_property = heading_properties(:one)
  end

  test "should get index" do
    get heading_properties_url
    assert_response :success
  end

  test "should get new" do
    get new_heading_property_url
    assert_response :success
  end

  test "should create heading_property" do
    assert_difference("HeadingProperty.count") do
      post heading_properties_url, params: { heading_property: { heading_id: @heading_property.heading_id, key: @heading_property.key, value: @heading_property.value } }
    end

    assert_redirected_to heading_property_url(HeadingProperty.last)
  end

  test "should show heading_property" do
    get heading_property_url(@heading_property)
    assert_response :success
  end

  test "should get edit" do
    get edit_heading_property_url(@heading_property)
    assert_response :success
  end

  test "should update heading_property" do
    patch heading_property_url(@heading_property), params: { heading_property: { heading_id: @heading_property.heading_id, key: @heading_property.key, value: @heading_property.value } }
    assert_redirected_to heading_property_url(@heading_property)
  end

  test "should destroy heading_property" do
    assert_difference("HeadingProperty.count", -1) do
      delete heading_property_url(@heading_property)
    end

    assert_redirected_to heading_properties_url
  end
end
