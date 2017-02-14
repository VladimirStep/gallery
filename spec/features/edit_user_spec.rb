require 'rails_helper'

RSpec.describe 'User Profile', :type => :feature do
  let(:user) { create(:user) }
  let(:new_email) { 'new@email.com' }
  let(:new_password) { 'new_password' }

  describe 'change user data', js: true do
    before do
      sign_in user
      visit edit_user_registration_path
    end

    it 'can change user email' do
      fill_in('Email', with: new_email)
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_current_path(root_path(locale: :en))
      expect(page).to have_content('Your account has been updated successfully.')
      expect(page).to have_content(new_email.upcase)
      user.reload
      expect(user.email).to eq(new_email)
    end

    it 'can change user password' do
      fill_in('Password', with: new_password)
      fill_in('Password confirmation', with: new_password )
      fill_in('Current password', with: user.password)
      click_button('Update')
      expect(page).to have_current_path(root_path(locale: :en))
      expect(page).to have_content('Your account has been updated successfully.')
      click_on(user.email)
      click_link('Sign out')
      expect(page).to have_content('Signed out successfully.')
      click_link('Sign in')
      fill_in('Email', with: user.email)
      fill_in('Password', with: new_password)
      click_button('Log in')
      expect(page).to have_content('Signed in successfully.')
    end
  end
end