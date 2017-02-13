require 'rails_helper'

RSpec.describe 'Sign in page', :type => :feature do
  let(:user) { create(:user) }
  let(:invalid_email) { 'invalid@email.com' }
  let(:invalid_password) { 'invalid' }

  describe 'with valid data', js: true do
    before { visit new_user_session_path }

    it 'can login' do
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button('Log in')
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content(user.email.upcase)
      expect(page).to have_current_path(categories_path(locale: :en))
    end
  end

  describe 'with invalid data', js: true do
    before { visit new_user_session_path }

    it 'can not login with invalid email' do
      fill_in('Email', with: invalid_email)
      fill_in('Password', with: user.password)
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path(locale: :en))
    end
  end

  describe 'captcha', js: true do
    before { visit new_user_session_path }

    it 'has no captcha for the first 3 times' do
      expect(page).to have_no_css('#recaptcha')
    end

    it 'shows captcha from the third attempt' do
      3.times { click_button('Log in') }
      expect(page).to have_css('#recaptcha')
    end

    it 'user can not login without captcha verifying' do
      3.times { click_button('Log in') }
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button('Log in')
      expect(page).to have_content('reCAPTCHA verification failed, please try again.')
    end
  end
end