# An apple a day keeps the doctor away
class UsersController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path unless current_user
    # ====== mail test ======
    # mail to user when he enter the user#show. It worked!
    # UserMailer.welcome_email(@user).deliver_now
    @followed_events = @user.user_followed_events
    @followed_artists = @user.user_followed_artists
    @favorited_artists = @user.favorited_artists
    @friends = @user.friends
    @followers = @user.followers
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(@user) unless @user == current_user
    @followed_events = @user.user_followed_events
    @followed_artists = @user.user_followed_artists
    @favorited_artists = @user.favorited_artists
    @friends = @user.friends
    @followers = @user.followers
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
      flash[:notice] = "#{current_user.name} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{current_user.name} was failed to update"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
