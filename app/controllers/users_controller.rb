class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def edit 
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def drafts
    @user = Post.find(params[:id]).user
    @drafts = @user.posts.drafts
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
