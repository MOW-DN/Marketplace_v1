class Settings::UsersController < Settings::BaseController
  def show
  end

  def destroy
    terminate_session
    Current.user.destroy
    redirect_to root_path, notice: "Your account has been deleted."
  end
end
