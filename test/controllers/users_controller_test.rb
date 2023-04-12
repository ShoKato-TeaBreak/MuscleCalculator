require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get users_home_url
    assert_response :success
  end

  test "should get account" do
    get users_account_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get signup" do
    get users_signup_url
    assert_response :success
  end
end
