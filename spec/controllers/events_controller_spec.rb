require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before { @user = create(:user) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #user_navigation' do
    it 'returns http success' do
      get :user_navigation, params: {id: @user.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #user_sign_in' do
    it 'returns http success' do
      get :user_sign_in, params: {id: @user.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #user_sign_out' do
    it 'returns http success' do
      get :user_sign_out, params: {id: @user.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #user_likes' do
    it 'returns http success' do
      get :user_likes, params: {id: @user.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end

  describe 'GET #user_comments' do
    it 'returns http success' do
      get :user_comments, params: {id: @user.id}
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'text/html'
      expect(response.body).to eq ''
    end
  end
end
