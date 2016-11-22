class EventsController < ApplicationController
  before_action :set_user, only: [:user_navigation, :user_likes, :user_comments]

  def index
    @users = User.all
  end

  def user_navigation
    @navigations = @user.events
  end

  def user_sign_in
    
  end

  def user_sign_out
    
  end

  def user_likes
    @likes = @user.likes
  end

  def user_comments
    @comments = @user.comments
  end

  def set_user
    @user = User.find(params[:id])
  end
end
