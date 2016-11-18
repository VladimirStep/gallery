class PicturesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    @pictures = Picture.all.order(likes_count: :desc)
  end

  def show
    @category = Category.find_by(category_name: params[:category_category_name])
    @picture = Picture.find_by(id: params[:id], category_id: @category.id)
    @comments = @picture.comments.order(created_at: :desc)
    @like = @picture.likes.where(user_id: current_user.id)
  end
end
