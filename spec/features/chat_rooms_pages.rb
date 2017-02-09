require 'rails_helper'

RSpec.feature 'ChatRoom pages', :type => :feature do
  subject { page }

  let(:user) { create(:user) }

  describe 'Index page' do
    before { 5.times { create(:chat_room, user: user) } }
    let(:chat_room) { ChatRoom.first }

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

    describe 'Click on New chat room', js: true do
      before do
        sign_in user
        visit chat_rooms_path
        click_on('New chat room')
      end

      it { should have_current_path(new_chat_room_path(locale: :en)) }
      it { should have_content('Add chat room') }
    end

    describe 'Click on chat room', js: true do
      before do
        sign_in user
        visit chat_rooms_path
        click_on("#{chat_room.title}")
      end

      it { should have_current_path(chat_room_path(chat_room, locale: :en)) }
      it { should have_content("#{chat_room.title}") }
    end
  end

  describe 'Show Chat' do
    let(:chat_room) { create(:chat_room, user: user) }
    let(:message) { 'Hello my firend' }

    context 'when user is not logged in' do
      before { visit chat_room_path(chat_room) }

      it { should have_css('div.alert.alert-danger') }
      it { should have_content('You need to sign in or sign up before continuing.') }
      it { should have_current_path(new_user_session_path(locale: :en)) }
    end

    context 'when user is logged in' do
      before do
        sign_in user
        page.driver.options[:headers] ||= {}
        page.driver.options[:headers]['REQUEST_PATH'] = chat_rooms_path
        visit chat_room_path(chat_room)
      end

      it { should have_content("#{chat_room.title}") }
      it { should have_button('Post') }
    end

    describe 'Post new message', js: true do
      before do
        sign_in user
        visit chat_room_path(chat_room)
      end

      it 'User can post his message' do
        expect(user.messages.count).to eq(0)
        within('#new_message') do
          fill_in('Your message', with: message)
        end
        click_button('Post')
        expect(find_field(id: 'message_body').value).to eq('')
        Capybara.using_wait_time 20 do
          expect(page).to have_css('#messages p', text: message)
          expect(user.messages.count).to eq(1)
        end
      end
    end
  end

  describe 'Create New Chat' do

  end
end