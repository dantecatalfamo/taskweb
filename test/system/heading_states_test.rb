require "application_system_test_case"

class HeadingStatesTest < ApplicationSystemTestCase
  setup do
    @heading_state = heading_states(:one)
  end

  test "visiting the index" do
    visit heading_states_url
    assert_selector "h1", text: "Heading states"
  end

  test "should create heading state" do
    visit heading_states_url
    click_on "New heading state"

    check "Done" if @heading_state.done
    fill_in "Name", with: @heading_state.name
    click_on "Create Heading state"

    assert_text "Heading state was successfully created"
    click_on "Back"
  end

  test "should update Heading state" do
    visit heading_state_url(@heading_state)
    click_on "Edit this heading state", match: :first

    check "Done" if @heading_state.done
    fill_in "Name", with: @heading_state.name
    click_on "Update Heading state"

    assert_text "Heading state was successfully updated"
    click_on "Back"
  end

  test "should destroy Heading state" do
    visit heading_state_url(@heading_state)
    click_on "Destroy this heading state", match: :first

    assert_text "Heading state was successfully destroyed"
  end
end
