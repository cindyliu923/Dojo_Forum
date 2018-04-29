class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :posts, :replies, :collects]

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
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def posts
    @posts = @user.posts.publishs
  end

  def show
    @posts = @user.posts.publishs    
  end

  def replies
    @replies = @user.replies
  end

  def collects
    @collects = @user.collects
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
