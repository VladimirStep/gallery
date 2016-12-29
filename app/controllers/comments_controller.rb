class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :find_picture, only: :create

  def index
    @comments = Comment.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    current_user.comments.create!(comment_params)
    @comments = @picture.comments.order(created_at: :desc).page(params[:page]).per(5)
    @comments_counter = @picture.comments.count
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(picture_id: params[:picture_id])
  end

  def find_picture
    @picture = Picture.find(params[:picture_id])
  end
end
