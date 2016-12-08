class PicturesController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
    @pictures = Picture.all.order(likes_count: :desc).page(params[:page]).per(5)
  end

  def show
    @category = Category.find_by(category_name: params[:category_category_name])
    @picture = Picture.find_by(id: params[:id], category_id: @category.id)
    @like = Like.find_by(picture_id: params[:id], user_id: current_user.id) if user_signed_in?
    @comments = @picture.comments.order(created_at: :desc).page(params[:page]).per(5)
  end
end
