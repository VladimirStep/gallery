require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  before do
    @user = create(:user)
    @category = create(:category)
  end

  describe 'POST #create' do
    context 'when user logged in' do
      it 'creates new subscription' do
        sign_in @user
        request.headers['REQUEST_PATH'] = subscriptions_path(@category)
        expect do
          post :create, xhr: true, params: { user_id: @user.id, category_id: @category.id }
        end.to change(@category.subscriptions, :count).by(1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context 'when user is not logged in' do
      it 'does not create new subscription' do
        expect do
          post :create, xhr: true, params: { user_id: @user.id, category_id: @category.id }
        end.not_to change(@category.subscriptions, :count)
        expect(response.status).to eq 401
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user logged in' do
      before { @subscription = create(:subscription, user: @user, category: @category) }

      it 'deletes subscription' do
        sign_in @user
        request.headers['REQUEST_PATH'] = subscription_path(@category, @subscription)
        expect do
          delete :destroy, xhr: true, params: { category_id: @category.id, id: @subscription.id }
        end.to change(@category.subscriptions, :count).by(-1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context 'when user is not logged in' do
      before { @subscription = create(:subscription, user: @user, category: @category) }

      it 'does not delete subscription' do
        expect do
          delete :destroy, xhr: true, params: { category_id: @category.id, id: @subscription.id }
        end.not_to change(@category.subscriptions, :count)
        expect(response.status).to eq 401
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end
end
