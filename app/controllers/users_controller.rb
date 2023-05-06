class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:title, :body)
  end
end
