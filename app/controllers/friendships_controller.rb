class FriendshipsController < ApplicationController

  def create
    friend = User.by_email(friend_email)

    if (friend.nil?)
      flash[:error] = 'Your friend cannot be found. Are you sure they exist?'
    else
      friendship = Friendship.new(user_id: session[:user_id], friend_id: friend.id)

      unless (friendship.save)
        flash[:error] = 'Your friend could not be saved.'
      end
    end

    redirect_to dashboard_path
  end

  private

  def friend_email
    params.permit(:friend_email)[:friend_email]
  end
end
