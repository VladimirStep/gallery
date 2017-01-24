class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(category_name: params[:category_name])
    @pictures = @category.pictures.page(params[:page]).per(8)
    @subscription = Subscription.find_by(category_id: @category.id, user_id: current_user.id) if user_signed_in?
  end
end
