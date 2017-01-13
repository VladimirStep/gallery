require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
  before do
    @chat_room = create(:chat_room)
    @user = create(:user)
  end

  describe 'GET #index' do
    context 'when user logged in' do
      it 'returns http success' do
        sign_in @user
        request.headers['REQUEST_PATH'] = chat_rooms_path
        get :index
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/html'
        expect(response.body).to eq ''
      end
    end

    context 'when user does not logged in' do
      it 'redirects to login page' do
        get :index
        expect(response.status).to eq 302
        expect(response.content_type).to eq 'text/html'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when user logged in' do
      it 'returns http success' do
        sign_in @user
        request.headers['REQUEST_PATH'] = chat_room_path(@chat_room)
        get :show, params: { id: @chat_room.id }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/html'
        expect(response.body).to eq ''
      end
    end

    context 'when user does not logged in' do
      it 'redirects to login page' do
        get :show, params: { id: @chat_room.id }
        expect(response.status).to eq 302
        expect(response.content_type).to eq 'text/html'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when user logged in' do
      it 'returns http success' do
        sign_in @user
        request.headers['REQUEST_PATH'] = new_chat_room_path
        get :new
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq 'text/html'
        expect(response.body).to eq ''
      end
    end

    context 'when user does not logged in' do
      it 'redirects to login page' do
        get :new
        expect(response.status).to eq 302
        expect(response.content_type).to eq 'text/html'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user logged in' do
      it 'returns http success' do
        sign_in @user
        request.headers['REQUEST_PATH'] = chat_rooms_path
        expect do
          post :create, params: { chat_room: { title: 'Test room' }, user_id: @user.id }
        end.to change(@user.chat_rooms, :count).by(1)
        expect(response.status).to eq 302
        expect(response.content_type).to eq 'text/html'
        expect(response).to redirect_to(chat_rooms_path)
      end
    end
  end
end
