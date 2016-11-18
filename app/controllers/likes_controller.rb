class LikesController < ApplicationController
  def create
    current_user.likes.create!(like_params)
    redirect_to category_picture_path(category_param[:category_name], picture_param[:picture_id])
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to category_picture_path(category_param[:category_name], picture_param[:picture_id])
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
