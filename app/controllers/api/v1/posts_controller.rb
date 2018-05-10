class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_permit_user, only: [:show]

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

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      if params[:category_ids]
        params[:category_ids].split(",").map(&:to_i).each do |category|
          CategoryOfPost.create!(category_id: category, post: @post)
        end
      end
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    if @post.user == current_user 
      if @post.update(post_params)
        render json: {
          message: "Post updated successfully!",
          result: @post
        }
      else
        render json: {
          errors: @post.errors
        }
      end
    else
      render json: {
        message: "Not allow!"
      }      
    end      
  end

  def destroy
    if @post.user == current_user || current_user.admin?
      @post.destroy
      render json: {
        message: "Post destroy successfully!"
      }
    else
      render json: {
        message: "Not allow!"
      }      
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(:title, :description, :permit, :image, :status)
  end

  def authenticate_permit_user
    if set_post
      unless set_post.permit_user?(current_user)
        render json: {
          message: "Not allow!"
        }
      end
    end
  end

end
