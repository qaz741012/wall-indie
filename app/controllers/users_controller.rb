class UsersController < ApplicationController

  def show
    
    @user = User.find(params[:id])
    # ====== mail test ======
    # mail to user when he enter the user#show. It worked!
    
    # UserMailer.welcome_email(@user).deliver_now
    @followed_events = @user.user_followed_events
    @followed_artists = @user.user_followed_artists
    @favorited_artists = @user.favorited_artists
    @friends = @user.friends
    @followers = @user.followers
  end

end
