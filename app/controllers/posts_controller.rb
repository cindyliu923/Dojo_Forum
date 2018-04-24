class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.all_publish
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
  end

end
