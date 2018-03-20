class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


end
