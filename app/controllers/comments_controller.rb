class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_to root_url
    # redirect_to category_picture_path(params[:category_name], params[:picture_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
