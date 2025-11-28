class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_confirmation.subject
  #
  def email_confirmation
    @token = params[:user].generate_token_for(:email_confirmation)
    mail to: params[:user].unconfirmed_email
  end
end
