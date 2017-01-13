require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before { @category = create(:category) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { category_name: @category.category_name }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end
end
