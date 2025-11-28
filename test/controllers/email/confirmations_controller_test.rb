require "test_helper"

class Email::ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "invalid tokens are ignored" do
    user = users(:one)
    previous_email = user.email_address
    user.update(unconfirmed_email: "new@example.org")
    get email_confirmation_path(token: "invalid")
    assert_equal "Invalid token.", flash[:alert]
    user.reload
    assert_equal previous_email, user.email_address
  end

  test "email is updated with a valid token" do
    user = users(:one)
    user.update(unconfirmed_email: "new@example.org")
    get email_confirmation_path(token: user.generate_token_for(:email_confirmation))
    assert_equal "Your email has been confirmed.", flash[:notice]
    user.reload
    assert_equal "new@example.org", user.email_address
    assert_nil user.unconfirmed_email
  end
end
