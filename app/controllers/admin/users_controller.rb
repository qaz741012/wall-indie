# user controller of admin
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'Successfully deleted user'
    redirect_back(fallback_location: admin_root_path)
  end
end
