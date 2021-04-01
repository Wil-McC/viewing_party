class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:message] = 'You entered bad credentials and you should feel bad'
      render :new
    end
  end

  def destroy
    session.delete :user_id
    flash[:message] = 'You have been logged out'
    redirect_to root_path
  end
end
