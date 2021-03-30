class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(current_user.id)
    @viewing_parties = @user.viewing_parties_involving_me
  end
end
