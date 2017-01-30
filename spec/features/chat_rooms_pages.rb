require 'rails_helper'

RSpec.feature 'ChatRoom pages', :type => :feature do
  subject { page }

  let(:user) { create(:user) }

  describe 'Index page' do
    before { 5.times { create(:chat_room, user: user) } }

    context 'when user is not logged in' do
      before { visit chat_rooms_path }

      it { should have_css('div.alert.alert-danger') }
      it { should have_content('You need to sign in or sign up before continuing.') }
      it { should have_current_path(new_user_session_path(locale: :en)) }
    end

    context 'when user is logged in' do
      before do
        sign_in user
        page.driver.options[:headers] ||= {}
        page.driver.options[:headers]['REQUEST_PATH'] = chat_rooms_path
        visit chat_rooms_path
      end

      it { should have_content('ChatRooms') }
      it { should have_link('New chat room') }
      it 'should have links to chat rooms' do
        expect(user.chat_rooms.count).to eq(5)
        within('.nav.nav-pills') do
          expect(all("a[href*='chat_rooms']").count).to eq(5)
        end
      end
    end
  end

  describe 'visit new chat room' do

  end

  describe 'enter to a chat' do

  end
end