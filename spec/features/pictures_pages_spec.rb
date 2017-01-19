require 'rails_helper'

RSpec.feature 'Pictures pages', :type => :feature do
  subject { page }

  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'User visit index page' do
    before do
      10.times { create(:picture, category_id: category.id) }
      visit root_path
    end

    it { should have_content('Pictures') }
    it { should have_css("img[src*='test.jpg']") }
    it { should have_selector('ul.pagination') }
    it 'shows only 5 pictures per page' do
      expect(all("img[src*='test.jpg']").count).to eq(5)
    end
  end

  describe 'Show page' do

  end
end