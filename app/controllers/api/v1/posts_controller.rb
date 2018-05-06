class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index

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

  def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render json: {
        data: @post
      }
    end
  end

end
