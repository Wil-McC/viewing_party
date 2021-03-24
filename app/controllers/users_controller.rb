class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      # refac?
      session[:user_id] = new_user.id
      redirect_to dashboard_index_path
    else
      flash[:message] = "Invalid Information Entered"
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
