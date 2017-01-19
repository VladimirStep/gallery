require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  before do
    @user = create(:user)
    @category = create(:category)
  end

  describe 'GET #index' do
    let!(:first_picture) { create(:picture, category_id: @category.id) }
    let!(:second_picture) { create(:picture, category_id: @category.id) }
    let!(:third_picture) { create(:picture, category_id: @category.id) }
    before { create(:like, picture: second_picture, user: @user) }

    it 'returns http success and sorts pictures by likes' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
      expect(assigns(:pictures)).to eq([second_picture, first_picture, third_picture])
    end
  end

  describe 'GET #show' do
    before { @picture = create(:picture, category_id: @category.id) }

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
