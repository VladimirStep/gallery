class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end

  def show
    @category = Category.find_by(category_name: params[:category_category_name])
    @picture = Picture.find_by(id: params[:id], category_id: @category.id)
    @comments = @picture.comments.order(created_at: :desc)
    @like = @picture.likes.where(user_id: current_user.id)
  end
end
