class Email::ConfirmationsController < ApplicationController
  allow_unauthenticated_access

  def show
    user = User.find_by_token_for(:email_confirmation, params[:token])
    if user&.confirm_email
      flash[:notice] = "Your email has been confirmed."
    else
      flash[:alert] = "Invalid token."
    end
    redirect_to root_path
  end
end
