class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])    
  end

  def sort_by
    sort_by = (params[:order] == 'replies_count') ? 'replies_count DESC' :
              (params[:order] == 'last_replied_at') ? 'replies.created_at DESC'  : 
              (params[:order] == 'vieweds_count') ? 'vieweds_count DESC' : 'id'
  end

  def authenticate_permit_user
    unless set_post.permit_user?(current_user)
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

end
