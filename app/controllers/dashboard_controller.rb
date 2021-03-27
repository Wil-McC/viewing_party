class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(current_user.id)
  end
end
