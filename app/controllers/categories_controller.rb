class CategoriesController < ApplicationController
  
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.posts.all_publish.includes(:replies).order(sort_by).page(params[:page]).per(20)
  end

end
