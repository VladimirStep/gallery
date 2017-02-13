require 'rails_helper'

RSpec.describe 'Sign up page', :type => :feature do
  let!(:user) { create(:user) }
  let(:email) { 'test@test.com' }
  let(:password) { 'password' }
  let(:wrong_password) { 'invalid' }

  describe 'create new user', js: true do
    before { visit new_user_registration_path }

    it 'creates new user when valid data provided' do
      expect(User.all.count).to eq(1)
      fill_in('Email', with: email)
      fill_in('Password', with: password)
      fill_in('Password confirmation', with: password)
      click_button('Sign up')
      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_current_path(categories_path(locale: :en))
      expect(User.all.count).to eq(2)
    end

    it 'does not create user with email duplicated' do
      expect(User.all.count).to eq(1)
      fill_in('Email', with: user.email)
      fill_in('Password', with: password)
      fill_in('Password confirmation', with: password)
      click_button('Sign up')
      expect(page).to have_content('Email has already been taken')
      expect(page).to have_current_path(user_registration_path(locale: :en))
      expect(User.all.count).to eq(1)
    end

    it 'does not create user without password confirmation' do
      expect(User.all.count).to eq(1)
      fill_in('Email', with: email)
      fill_in('Password', with: password)
      fill_in('Password confirmation', with: wrong_password)
      click_button('Sign up')
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_current_path(user_registration_path(locale: :en))
      expect(User.all.count).to eq(1)
    end
  end
end