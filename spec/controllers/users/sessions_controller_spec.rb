require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before { @user = create(:user) }

  describe 'POST #create' do
    it 'should track user and write confirmation to the db' do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.headers['REQUEST_PATH'] = user_session_path
      expect do
        post :create, params: { user: { email: @user.email, password: @user.password } }
      end.to change(@user.events.where(confirmation: true), :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    it 'should track user and write confirmation to the db' do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.headers['REQUEST_PATH'] = user_session_path
      post :create, params: { user: { email: @user.email, password: @user.password } }
      request.headers['REQUEST_PATH'] = destroy_user_session_path
      expect do
        delete :destroy
      end.to change(@user.events.where(confirmation: true), :count).by(1)
    end
  end
end