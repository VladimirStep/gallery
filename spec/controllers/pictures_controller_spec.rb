require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  before do
    @picture = create(:picture)
    @user = create(:user)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #show' do
    context 'when user logged in' do
      it 'returns http success' do
        sign_in @user
        request.headers['REQUEST_PATH'] = category_picture_path(@picture.category.category_name, @picture.id)
        get :show, params: { category_category_name: @picture.category.category_name, id: @picture.id }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/html'
        expect(response.body).to eq ''
      end
    end

    context 'when user does not logged in' do
      it 'redirects to login page' do
        get :show, params: { category_category_name: @picture.category.category_name, id: @picture.id }
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        expect(response.content_type).to eq 'text/html'
      end
    end
  end
end
