class UsersController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:title, :body)
  end
end
