class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(role: params[:role])
      redirect_to admin_users_path
      flash[:notice] = "role was successfully updated"
    else
      @users = User.all
      render :index
    end
  end

end
