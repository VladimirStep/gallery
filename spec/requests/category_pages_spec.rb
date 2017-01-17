require 'rails_helper'

describe 'Category pages', :type => :request do
  subject { page }

  before do
    @categories = [
        create(:category, category_name: 'Ruby'),
        create(:category, category_name: 'Cats')
    ]
  end

  let(:picture) { create(:picture, category_id: @categories.first.id) }
  let(:other_category_picture) { create(:picture,
                                        category_id: @categories.last.id,
                                        image: File.open(Rails.root.join('spec', 'fixtures', 'test1.jpg'))) }

  describe 'index page' do
    before { visit categories_path }

    it { should have_content('Categories') }
    it { should have_content('RUBY') }
    it { should have_content('CATS') }
  end

  describe 'show page' do
    before do
      picture.reload
      other_category_picture.reload
      visit category_path(@categories.first.category_name)
    end

    it { should have_content('Ruby') }
    it { should have_css("img[src*='test.jpg']") }
    it { should_not have_css("img[src*='test1.jpg']") }
    it { should have_content('0 likes') }
  end

end