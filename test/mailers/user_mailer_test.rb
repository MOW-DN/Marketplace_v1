require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "email_confirmation" do
    user = users(:one)
    user.update(unconfirmed_email: "new@example.org")
    mail = UserMailer.with(user: user).email_confirmation
    assert_equal "Email confirmation", mail.subject
    assert_equal [ "new@example.org" ], mail.to
    assert_match "/email/confirmations/", mail.body.encoded
  end
end
