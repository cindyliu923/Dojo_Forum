class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def sort_by
    sort_by = (params[:order] == 'replies_count') ? 'replies_count DESC' :
              (params[:order] == 'last_replied_at') ? 'replies.created_at DESC'  : 
              (params[:order] == 'vieweds_count') ? 'vieweds_count DESC' : 'id'
  end

end
