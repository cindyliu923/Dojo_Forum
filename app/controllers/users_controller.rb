class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :posts, :replies, :collects, :drafts, :friends]
  before_action :find_posts, only: [:posts, :show]

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
    @drafts = @user.posts.drafts
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def replies
    @replies = @user.replies.where('post_id IN (?)',@user.replied_posts.all_publish(current_user).ids)
  end

  def collects
    @collects = @user.collects.where('post_id IN (?)',@user.collected_posts.all_publish(current_user).ids)
  end

  def friends
    @friends = @user.all_friends
    @wait_friends = @user.wait_friends
    @unconfirm_friends = @user.unconfirm_friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def find_posts
    @posts = @user.posts.all_publish(current_user) 
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

end
