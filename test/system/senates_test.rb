require "application_system_test_case"

class SenatesTest < ApplicationSystemTestCase
  setup do
    @senate = senates(:one)
  end

  test "visiting the index" do
    visit senates_url
    assert_selector "h1", text: "Senates"
  end

  test "should create senate" do
    visit senates_url
    click_on "New senate"

    fill_in "Date", with: @senate.date
    fill_in "Senate class", with: @senate.senate_class
    fill_in "State", with: @senate.state
    click_on "Create Senate"

    assert_text "Senate was successfully created"
    click_on "Back"
  end

  test "should update Senate" do
    visit senate_url(@senate)
    click_on "Edit this senate", match: :first

    fill_in "Date", with: @senate.date
    fill_in "Senate class", with: @senate.senate_class
    fill_in "State", with: @senate.state
    click_on "Update Senate"

    assert_text "Senate was successfully updated"
    click_on "Back"
  end

  test "should destroy Senate" do
    visit senate_url(@senate)
    click_on "Destroy this senate", match: :first

    assert_text "Senate was successfully destroyed"
  end
end
