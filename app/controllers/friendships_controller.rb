# 1234
class FriendshipsController < ApplicationController
  def create
    @user = User.find(params[:friend_id])
    unless @user == current_user
      @friendship = current_user.build(friend_id: params[:friend_id])
      if @friendship.save
        flash[:notice] = "Successfully friended #{@friendship.friend.name}"
      else
        flash[:alert] = @friendship.errors.full_messages.to_sentence
      end
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "You can't follow yourself."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "friendship destroyed with #{@friendship.friend.name}"
    redirect_back(fallback_location: root_path)
  end
end
