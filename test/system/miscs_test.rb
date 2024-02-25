require "application_system_test_case"

class MiscsTest < ApplicationSystemTestCase
  setup do
    @misc = miscs(:one)
  end

  test "visiting the index" do
    visit miscs_url
    assert_selector "h1", text: "Miscs"
  end

  test "should create misc" do
    visit miscs_url
    click_on "New misc"

    fill_in "Date", with: @misc.date
    fill_in "Race type", with: @misc.race_type
    fill_in "Seat", with: @misc.seat
    fill_in "State", with: @misc.state
    click_on "Create Misc"

    assert_text "Misc was successfully created"
    click_on "Back"
  end

  test "should update Misc" do
    visit misc_url(@misc)
    click_on "Edit this misc", match: :first

    fill_in "Date", with: @misc.date
    fill_in "Race type", with: @misc.race_type
    fill_in "Seat", with: @misc.seat
    fill_in "State", with: @misc.state
    click_on "Update Misc"

    assert_text "Misc was successfully updated"
    click_on "Back"
  end

  test "should destroy Misc" do
    visit misc_url(@misc)
    click_on "Destroy this misc", match: :first

    assert_text "Misc was successfully destroyed"
  end
end
