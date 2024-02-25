require "application_system_test_case"

class GovernorsTest < ApplicationSystemTestCase
  setup do
    @governor = governors(:one)
  end

  test "visiting the index" do
    visit governors_url
    assert_selector "h1", text: "Governors"
  end

  test "should create governor" do
    visit governors_url
    click_on "New governor"

    fill_in "Date", with: @governor.date
    fill_in "State", with: @governor.state
    click_on "Create Governor"

    assert_text "Governor was successfully created"
    click_on "Back"
  end

  test "should update Governor" do
    visit governor_url(@governor)
    click_on "Edit this governor", match: :first

    fill_in "Date", with: @governor.date
    fill_in "State", with: @governor.state
    click_on "Update Governor"

    assert_text "Governor was successfully updated"
    click_on "Back"
  end

  test "should destroy Governor" do
    visit governor_url(@governor)
    click_on "Destroy this governor", match: :first

    assert_text "Governor was successfully destroyed"
  end
end
