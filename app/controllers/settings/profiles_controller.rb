class Settings::ProfilesController < Settings::BaseController
  def show
  end

  def update
    if Current.user.update(profile_params)
      redirect_to settings_profile_path, status: :see_other, notice: "Your profile was updated successfully."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def profile_params
      params.expect(user: [ :first_name, :last_name ])
    end
end
