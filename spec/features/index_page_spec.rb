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
end