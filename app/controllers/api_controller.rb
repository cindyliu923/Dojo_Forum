class ApiController < ActionController::Base
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    if params[:auth_token].present?
      user = User.find_by_authentication_token( params[:auth_token] )

      # Devise: 設定 current_user
      sign_in(user, store: false) if user
    end
  end

  def permit_user?(user)
    Post.permit == 'friend' && Post.user.beconnect_friends_ids(Post.user).include?(user.id) ||
    Post.permit == 'myself' && Post.user == user ||
    Post.permit == 'all'
  end
end
