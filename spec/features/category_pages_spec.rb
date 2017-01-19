require 'rails_helper'

describe 'Category pages', :type => :feature do
  subject { page }

  before do
    @categories = [
        create(:category, category_name: 'Ruby'),
        create(:category, category_name: 'Cats')
    ]
  end

  let(:category) { @categories.first }
  let(:picture) { create(:picture, category_id: @categories.first.id) }
  let(:other_category_picture) { create(:picture,
                                        category_id: @categories.last.id,
                                        image: File.open(Rails.root.join('spec', 'fixtures', 'test1.jpg'))) }
  let(:user) { create(:user) }

  describe 'index page' do
    before { visit categories_path }

    it { should have_content('Categories') }
    it { should have_content('RUBY') }
    it { should have_content('CATS') }
  end

  describe 'show page' do
    before do
      category.reload
      picture.reload
      other_category_picture.reload
      visit category_path(category.category_name)
    end

    it { should have_content('Ruby') }
    it { should have_css("img[src*='test.jpg']") }
    it { should_not have_css("img[src*='test1.jpg']") }
    it { should have_content('0 likes') }

    context 'when user logged in' do
      it 'should have form for subscribe to category' do
        sign_in user
        page.driver.options[:headers] ||= {}
        page.driver.options[:headers]['REQUEST_PATH'] = category_path(category.category_name)
        visit category_path(category.category_name)
        expect(page).to have_css('div#subscribe-form')
      end
    end

    context 'when user is not logged in' do
      it 'should not have form for subscribe to category' do
        visit category_path(category.category_name)
        expect(page).not_to have_css('div#subscribe-form')
      end
    end
  end

  describe 'click on Subscribe/Unsubscribe on show page' do
    before do
      ImageUploader.enable_processing = true
      category.reload
      picture.reload
      user.reload
    end

    after do
      ImageUploader.enable_processing = false
      picture.remove_image!
    end

    it 'should toggle subscription to category and switch between Subscribe/Unsubscribe form', js: true do
      sign_in user
      visit category_path(category.category_name)
      expect(page).to have_css("input[value='Subscribe']")
      expect(user.subscriptions.count).to eq(0)

      click_on('Subscribe')
      expect(page).to have_css("input[value='Unsubscribe']")
      expect(user.subscriptions.count).to eq(1)

      click_on('Unsubscribe')
      expect(page).to have_css("input[value='Subscribe']")
      expect(user.subscriptions.count).to eq(0)
    end
  end
end