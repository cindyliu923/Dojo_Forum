class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect]

  def index
    @posts = Post.all_publish(current_user).includes(:replies).order(sort_by).page(params[:page]).per(20)
    @categories = Category.all
  end

  def new
    @post = Post.new
    @categories = Category.all
    @category = @post.categories.ids
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
    elsif params[:commit] == "Save Draft"
      @post.status = 'draft'
      if @post.save
        create_categories
        redirect_to drafts_user_path(@post.user)
      else
        render :new
      end
    end
  end

  def edit
    @categories = Category.all
    @category = @post.categories.ids
    unless @post.user == current_user
      redirect_to user_path(@post.user)
    end
  end

  def update
    if params[:commit] == "Submit"
      @post.status = 'publish'
      if @post.update(post_params)
        create_categories
        redirect_to post_path(@post)
      else
        flash.now[:alert] = "post was failed to update"
        render :edit
      end
    elsif params[:commit] == "Save Draft"
      if @post.update(post_params)
        create_categories
        flash[:notice] = "post was successfully updated"      
        redirect_to drafts_user_path(@post.user)
      else
        flash.now[:alert] = "post was failed to update"
        render :edit
      end
    end
  end

  def destroy
    @post.destroy
    redirect_back(fallback_location: root_path)
    flash[:alert] = "draft was deleted"
  end

  def show
    add_view
    @user = @post.user
    @reply = Reply.new
    @replies = @post.replies.page(params[:page]).per(20)
  end

  def collect
    @post.collects.create!(user: current_user)
  end

  def uncollect
    collect = Collect.where(post: @post, user: current_user)
    collect.destroy_all
  end

  def feeds
    @users_count = User.all.size
    @post_count = Post.publishs.size
    @replies_count = Reply.all.size
    @popular_posts = Post.all_publish(current_user).order(replies_count: :desc).limit(10)
    @chatterbox_user = User.left_joins(:replies).group(:id).order('COUNT(replies.id) DESC').limit(10)
  end

  private

  def add_view 
    Viewed.create(post: @post, user: current_user)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :permit, :image)
  end

  def create_categories
    if params["categories"].present?
      params["categories"].each do |key, value|
        if value == {"category_of_post_ids"=>"1"}
          if @post.category_of_posts.where(category_id: key).empty?
            @post.category_of_posts.create(category_id: key)
          end
        elsif value == {"category_of_post_ids"=>"0"}
          if @post.category_of_posts.where(category_id: key).exists?
            @post.category_of_posts.where(category_id: key).destroy_all
          end          
        end
      end
    end
  end

end
