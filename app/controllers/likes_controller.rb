class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_picture

  def create
    @like = current_user.likes.create!(like_params)
  end

  def destroy
    Like.find(params[:id]).destroy
  end

  private

  def like_params
    params.permit(:picture_id)
  end

  def find_picture
    @picture = Picture.find(params[:picture_id])
  end
end
