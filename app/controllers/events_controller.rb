class EventsController < ApplicationController
  def index
    @users = User.all
  end

  def user_navigation
    @user = User.find(params[:id])
  end

  def user_sign_in
    
  end

  def user_sign_out
    
  end

  def user_likes
    @user = User.find(params[:id])
    @likes = @user.likes
  end

  def user_comments
    @user = User.find(params[:id])
    @comments = @user.comments
  end
end
