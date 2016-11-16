class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(category_name: params[:category_name])
    @pictures = @category.pictures
  end

  private


end
