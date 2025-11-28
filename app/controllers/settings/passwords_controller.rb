class Settings::PasswordsController < Settings::BaseController
  def show
  end

  def update
    if Current.user.update(password_params)
      redirect_to settings_profile_path, status: :see_other, notice: "Your password has been updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def password_params
      params.expect(user: [ :password, :password_confirmation, :password_challenge ]).with_defaults(password_challenge: "")
    end
end
