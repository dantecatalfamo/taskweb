require "application_system_test_case"

class HeadingPropertiesTest < ApplicationSystemTestCase
  setup do
    @heading_property = heading_properties(:one)
  end

  test "visiting the index" do
    visit heading_properties_url
    assert_selector "h1", text: "Heading properties"
  end

  test "should create heading property" do
    visit heading_properties_url
    click_on "New heading property"

    fill_in "Heading", with: @heading_property.heading_id
    fill_in "Key", with: @heading_property.key
    fill_in "Value", with: @heading_property.value
    click_on "Create Heading property"

    assert_text "Heading property was successfully created"
    click_on "Back"
  end

  test "should update Heading property" do
    visit heading_property_url(@heading_property)
    click_on "Edit this heading property", match: :first

    fill_in "Heading", with: @heading_property.heading_id
    fill_in "Key", with: @heading_property.key
    fill_in "Value", with: @heading_property.value
    click_on "Update Heading property"

    assert_text "Heading property was successfully updated"
    click_on "Back"
  end

  test "should destroy Heading property" do
    visit heading_property_url(@heading_property)
    click_on "Destroy this heading property", match: :first

    assert_text "Heading property was successfully destroyed"
  end
end
