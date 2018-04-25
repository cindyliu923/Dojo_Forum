class CategoriesController < ApplicationController
  
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.posts.all_publish.page(params[:page]).per(20)
  end

end
