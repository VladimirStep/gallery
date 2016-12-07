class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.find_by(category_name: category_param[:category_name])
    @picture = Picture.find_by(id: picture_param[:picture_id], category_id: @category.id)
    @like = @picture.likes.where(user_id: current_user.id)

    current_user.likes.create!(like_params)
    respond_to do |format|
      format.html { redirect_to category_picture_path(category_param[:category_name], picture_param[:picture_id]) }
      format.js
    end
  end

  def destroy
    @category = Category.find_by(category_name: category_param[:category_name])
    @picture = Picture.find_by(id: picture_param[:picture_id], category_id: @category.id)
    @like = @picture.likes.where(user_id: current_user.id)

    Like.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to category_picture_path(category_param[:category_name], picture_param[:picture_id]) }
      format.js
    end
  end

  private

  def like_params
    params.require(:like).permit(:picture_id)
  end

  def category_param
    params.require(:like).permit(:category_name)
  end

  def picture_param
    params.require(:like).permit(:picture_id)
  end
end
