require 'rails_helper'

RSpec.describe 'Sign out', :type => :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit root_path
  end

  it 'successfully process sign out action when click Sign out', js: true do
    click_on(user.email)
    click_link('Sign out')
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_no_content(user.email)
    expect(page).to have_link('Sign in')
  end
end