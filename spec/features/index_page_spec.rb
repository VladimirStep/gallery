require 'rails_helper'

RSpec.describe 'Index page', :type => :feature do
  subject { page }
  let(:user) { create(:user) }

  context 'when user is logged in' do
    describe 'header should have content' do
      before do
        sign_in user
        page.driver.options[:headers] ||= {}
        page.driver.options[:headers]['REQUEST_PATH'] = root_path
        visit root_path
      end

      it { should have_no_link('Sign in') }
      it { should have_no_link('Sign up') }
      it { should have_link('Categories') }
      it { should have_link('Pictures') }
      it { should have_link('en') }
      it { should have_link('ru') }
      it { should have_link('Chat rooms') }
      it { should have_link('Comments') }
      it { should have_link('Events') }
      it { should have_link('Profile') }
      it { should have_link('Sign out') }
      it { should have_content("#{user.email}") }
    end
  end

  context 'when user is not logged in' do
    describe 'header should have content' do
      before { visit root_path }

      it { should have_link('Sign in') }
      it { should have_link('Sign up') }
      it { should have_link('Categories') }
      it { should have_link('Pictures') }
      it { should have_link('en') }
      it { should have_link('ru') }
      it { should have_no_link('Chat rooms') }
      it { should have_no_link('Comments') }
      it { should have_no_link('Events') }
      it { should have_no_link('Profile') }
      it { should have_no_link('Sign out') }
    end
  end

  describe 'localization' do
    before do
      sign_in user
      page.driver.options[:headers] ||= {}
      page.driver.options[:headers]['REQUEST_PATH'] = root_path
      visit root_path
    end

    it 'should have Russian locale' do
      click_link('ru')
      expect(page).to have_content('Категории')
      expect(page).to have_content('Картинки')
      expect(page).to have_content('Чаты')
      expect(page).to have_content('Комментарии')
      expect(page).to have_content('Действия')
      expect(page).to have_content('Профиль')
    end

    it 'should have English locale' do
      click_link('en')
      expect(page).to have_content('Categories')
      expect(page).to have_content('Pictures')
      expect(page).to have_content('Chat rooms')
      expect(page).to have_content('Comments')
      expect(page).to have_content('Events')
      expect(page).to have_content('Profile')
    end
  end
end