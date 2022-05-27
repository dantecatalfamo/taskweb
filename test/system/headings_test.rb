require "application_system_test_case"

class HeadingsTest < ApplicationSystemTestCase
  setup do
    @heading = headings(:one)
  end

  test "visiting the index" do
    visit headings_url
    assert_selector "h1", text: "Headings"
  end

  test "should create heading" do
    visit headings_url
    click_on "New heading"

    fill_in "Body", with: @heading.body
    fill_in "Deadline", with: @heading.deadline
    fill_in "Scheduled", with: @heading.scheduled
    fill_in "Status", with: @heading.status
    fill_in "Title", with: @heading.title
    click_on "Create Heading"

    assert_text "Heading was successfully created"
    click_on "Back"
  end

  test "should update Heading" do
    visit heading_url(@heading)
    click_on "Edit this heading", match: :first

    fill_in "Body", with: @heading.body
    fill_in "Deadline", with: @heading.deadline
    fill_in "Scheduled", with: @heading.scheduled
    fill_in "Status", with: @heading.status
    fill_in "Title", with: @heading.title
    click_on "Update Heading"

    assert_text "Heading was successfully updated"
    click_on "Back"
  end

  test "should destroy Heading" do
    visit heading_url(@heading)
    click_on "Destroy this heading", match: :first

    assert_text "Heading was successfully destroyed"
  end
end
