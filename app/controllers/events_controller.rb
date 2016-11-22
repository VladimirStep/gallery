class EventsController < ApplicationController
  before_action :set_user, only: [:user_navigation, :user_likes, :user_comments, :user_sign_in, :user_sign_out]

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def user_navigation
    @navigations = @user.events.page(params[:page]).per(20)
  end

  def user_sign_in
    @actions = @user.events.where(url: '/users/sign_in', confirmation: true).page(params[:page]).per(20)
  end

  def user_sign_out
    @actions = @user.events.where(url: '/users/sign_out', confirmation: true).page(params[:page]).per(20)
  end

  def user_likes
    @likes = @user.likes.page(params[:page]).per(20)
  end

  def user_comments
    @comments = @user.comments.page(params[:page]).per(20)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
