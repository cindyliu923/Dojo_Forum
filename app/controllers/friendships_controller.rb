class FriendshipsController < ApplicationController
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
    redirect_back(fallback_location: root_path)
  end

  def connect
    if Friendship.where(user_id: params[:friend_id], friend_id: current_user).update(status: 'connect')
      flash[:notice] = "Successfully be friend!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = "friendship was failed to connect"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]) 
    @friendship.destroy_all 
    flash[:alert] = "Friendship canceled"
    redirect_back(fallback_location: root_path)
  end
end
