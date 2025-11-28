require "test_helper"

class SignUpsControllerTest < ActionDispatch::IntegrationTest
  test "view sign up" do
    get sign_up_path
    assert_response :success
  end
  test "successful sign up" do
  assert_difference "User.count" do
    post sign_up_path, params: { user: { first_name: "Example", last_name: "User", email_address: "example@user.org", password: "password", password_confirmation: "password" } }
    assert_redirected_to root_path
  end
end
test "invalid sign up" do
  assert_no_difference "User.count" do
    post sign_up_path, params: { user: { email_address: "example@user.org", password: "password", password_confirmation: "password" } }
    assert_response :unprocessable_entity
  end
end
test "sign up ignores admin attribute" do
  assert_difference "User.count" do
    post sign_up_path, params: { user: { first_name: "Example", last_name: "User", email_address: "example@user.org", password: "password", password_confirmation: "password", admin: true } }
    assert_redirected_to root_path
  end
  refute User.find_by(email_address: "example@user.org").admin?
end
end
