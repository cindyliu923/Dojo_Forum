class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all_publish
    @categories = Category.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:commit] == "Submit"
      @post.status = 'publish'
      if @post.save
        create_categories
        redirect_to post_path(@post)
      else
        render :new
      end
    elsif params[:commit] == "draft"
      @post.status = 'draft'
      if @post.save
        create_categories
        redirect_to draft_user_path(@post)
      else
        render :new
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :permit, :image)
  end

  def create_categories
    if params["categories"].present?
      params["categories"].each do |key, value|
        if value == {"category_of_post_ids"=>"1"}
          @post.category_of_posts.create(category_id: key)
        end
      end
    end
  end

end
