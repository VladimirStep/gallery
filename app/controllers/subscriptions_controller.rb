class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category

  def create
    @subscription = current_user.subscriptions.create!(subscription_params)
  end

  def destroy
    Subscription.find(params[:id]).destroy
  end

  private

  def subscription_params
    params.permit(:category_id)
  end

  def find_category
    @category = Category.find(params[:category_id])
  end
end
