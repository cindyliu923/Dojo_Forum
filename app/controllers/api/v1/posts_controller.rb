class Api::V1::PostsController < ApiController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.all_publish(current_user)
    else
      @posts = Post.all_publish(current_user)
    end
    render json: {
      data: @posts
    }
  end

end
