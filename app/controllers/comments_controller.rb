class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @comments = Comment.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    current_user.comments.create!(comment_params)
    redirect_to category_picture_path(category_param[:category_name], picture_param[:picture_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :picture_id)
  end

  def category_param
    params.require(:comment).permit(:category_name)
  end

  def picture_param
    params.require(:comment).permit(:picture_id)
  end
end
