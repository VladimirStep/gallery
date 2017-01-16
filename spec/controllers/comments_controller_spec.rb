require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = create(:user)
    @picture = create(:picture)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'POST #create' do
    context 'when user logged in' do
      it 'creates new comment' do
        sign_in @user
        request.headers['REQUEST_PATH'] = create_comment_path(@picture)
        expect do
          post :create, xhr: true, params: { picture_id: @picture.id, user_id: @user.id, comment: { body: 'Lorem ip sum' } }
        end.to change(@picture.comments, :count).by(1)
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/javascript'
      end
    end

    context 'when user does not logged in' do
      it 'does not create new comment' do
        expect do
          post :create, xhr: true, params: { picture_id: @picture.id, user_id: @user.id, comment: { body: 'Lorem ip sum' } }
        end.not_to change(@picture.comments, :count)
        expect(response.status).to eq 401
        expect(response.content_type).to eq 'text/javascript'
      end
    end
  end

end
