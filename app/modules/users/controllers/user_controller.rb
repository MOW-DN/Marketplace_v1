module Users
  class UsersController < ApplicationController
    def index
      @users = Users.all
    end

    def show
      @user = Users.find(params[:id])
    end



    private

    def user_params
      params.require(:users).permit(:name, :email)
    end
  end
end
