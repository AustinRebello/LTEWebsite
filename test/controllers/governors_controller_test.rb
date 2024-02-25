require "test_helper"

class GovernorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @governor = governors(:one)
  end

  test "should get index" do
    get governors_url
    assert_response :success
  end

  test "should get new" do
    get new_governor_url
    assert_response :success
  end

  test "should create governor" do
    assert_difference("Governor.count") do
      post governors_url, params: { governor: { date: @governor.date, state: @governor.state } }
    end

    assert_redirected_to governor_url(Governor.last)
  end

  test "should show governor" do
    get governor_url(@governor)
    assert_response :success
  end

  test "should get edit" do
    get edit_governor_url(@governor)
    assert_response :success
  end

  test "should update governor" do
    patch governor_url(@governor), params: { governor: { date: @governor.date, state: @governor.state } }
    assert_redirected_to governor_url(@governor)
  end

  test "should destroy governor" do
    assert_difference("Governor.count", -1) do
      delete governor_url(@governor)
    end

    assert_redirected_to governors_url
  end
end
