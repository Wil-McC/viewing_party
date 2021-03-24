class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      flash[:message] = 'You entered bad credentials and you should feel bad'
      render :new
    end
  end
end
