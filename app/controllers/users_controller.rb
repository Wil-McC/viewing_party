class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      # refac?
      session[:user_id] = new_user.id
      redirect_to dashboard_index_path
    else
      flash[:message] = 'Invalid Information Entered'
      redirect_to registration_path
    end
  end

  private

  def user_params
    new_user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    new_user_params[:email].downcase!
    new_user_params
  end
end
