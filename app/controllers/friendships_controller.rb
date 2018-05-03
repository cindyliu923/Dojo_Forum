class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_friend, only: [:ignore, :connect]

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: 'send')
    if @friendship.save
      flash[:notice] = "Successfully send friend request!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def ignore
    Friendship.where(user_id: params[:friend_id], friend_id: current_user).update(status: 'ignore')
  end

  def connect
    Friendship.where(user_id: params[:friend_id], friend_id: current_user).update(status: 'connect')
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]) 
    @friendship.destroy_all 
    flash[:alert] = "Friendship canceled!"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_friend
    @friend = User.find(params[:friend_id])
  end

end
