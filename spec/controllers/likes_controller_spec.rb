require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create(:user)
    @picture = create(:picture)
  end

  describe 'POST #create' do
    context 'when user logged in' do
      it 'creates new like' do
        sign_in @user
        request.headers['REQUEST_PATH'] = likes_path(@picture)
        expect do
          post :create, xhr: true, params: { user_id: @user.id, picture_id: @picture.id }
        end.to change(@picture.likes, :count).by(1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context 'when user is not logged in' do
      it 'does not create new like' do
        expect do
          post :create, xhr: true, params: { user_id: @user.id, picture_id: @picture.id }
        end.not_to change(@picture.likes, :count)
        expect(response.status).to eq 401
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user logged in' do
      before { @like = create(:like, picture: @picture, user: @user) }

      it 'deletes like' do
        sign_in @user
        request.headers['REQUEST_PATH'] = like_path(@picture, @like)
        expect do
          delete :destroy, xhr: true, params: { picture_id: @picture.id, id: @like.id }
        end.to change(@picture.likes, :count).by(-1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context 'when user is not logged in' do
      before { @like = create(:like, picture: @picture, user: @user) }

      it 'does not delete like' do
        expect do
          delete :destroy, xhr: true, params: { picture_id: @picture.id, id: @like.id }
        end.not_to change(@picture.likes, :count)
        expect(response.status).to eq 401
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end
end
