require "test_helper"

class SenatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @senate = senates(:one)
  end

  test "should get index" do
    get senates_url
    assert_response :success
  end

  test "should get new" do
    get new_senate_url
    assert_response :success
  end

  test "should create senate" do
    assert_difference("Senate.count") do
      post senates_url, params: { senate: { date: @senate.date, senate_class: @senate.senate_class, state: @senate.state } }
    end

    assert_redirected_to senate_url(Senate.last)
  end

  test "should show senate" do
    get senate_url(@senate)
    assert_response :success
  end

  test "should get edit" do
    get edit_senate_url(@senate)
    assert_response :success
  end

  test "should update senate" do
    patch senate_url(@senate), params: { senate: { date: @senate.date, senate_class: @senate.senate_class, state: @senate.state } }
    assert_redirected_to senate_url(@senate)
  end

  test "should destroy senate" do
    assert_difference("Senate.count", -1) do
      delete senate_url(@senate)
    end

    assert_redirected_to senates_url
  end
end
