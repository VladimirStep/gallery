class EventsController < ApplicationController
  before_action :set_user, only: [:user_navigation, :user_likes, :user_comments, :user_sign_in, :user_sign_out]

  def index
    @users = User.all
  end

  def user_navigation
    @navigations = @user.events
  end

  def user_sign_in
    @actions = @user.events.where(url: '/users/sign_in', confirmation: true)
  end

  def user_sign_out
    @actions = @user.events.where(url: '/users/sign_out', confirmation: true)
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
