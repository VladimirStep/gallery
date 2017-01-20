require 'rails_helper'

RSpec.feature 'Pictures pages', :type => :feature do
  subject { page }

  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'Index page' do
    before do
      10.times { create(:picture, category: category) }
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
    let(:picture) { create(:picture, category: category) }

    context 'when user is not logged in' do
      before do
        visit category_picture_path(category_category_name: category.category_name, id: picture.id)
      end

      it { should have_css('div.alert.alert-danger') }
      it { should have_content('You need to sign in or sign up before continuing.') }
      it { should have_current_path(new_user_session_path(locale: :en)) }
    end

    context 'when user is logged in' do
      before do
        sign_in user
        page.driver.options[:headers] ||= {}
        page.driver.options[:headers]['REQUEST_PATH'] = category_picture_path(category_category_name: category.category_name, id: picture.id)
        visit category_picture_path(category_category_name: category.category_name, id: picture.id)
      end

      it { should have_css("img[src*='#{picture.image_identifier}']") }
      it { should have_css('div#like-form') }
      it { should have_css('div#comment-form') }
    end
  end

  describe 'Modal window on show page' do
    let(:picture) { create(:picture, category: category) }

    before do
      sign_in user
      visit category_picture_path(category_category_name: category.category_name, id: picture.id)
    end

    it 'should open/close modal window', js: true do
      expect(page).to have_no_css('body.modal-open')
      expect(page).to have_no_css('div#myModal', visible: true)

      find_link(class: 'thumbnail', href: '#').click
      expect(page).to have_css('body.modal-open')
      expect(page).to have_css('div#myModal', visible: true)

      click_on('Close')
      expect(page).to have_no_css('body.modal-open')
      expect(page).to have_no_css('div#myModal', visible: true)
    end
  end

  describe 'Like form on Show page' do
    let(:picture) { create(:picture, category: category) }

    before do
      sign_in user
      visit category_picture_path(category_category_name: category.category_name, id: picture.id)
    end

    it 'User can create/delete like on the picture', js: true do
      expect(page).to have_css("input[src*='like_empty-']")
      expect(page).to have_content('0 likes')
      expect(picture.likes.count).to eq(0)
      within('#like-form') do
        click_on('Submit')
      end
      expect(page).to have_css("input[src*='like-']")
      expect(page).to have_content('1 like')
      expect(picture.likes.count).to eq(1)
      within('#like-form') do
        click_on('Submit')
      end
      expect(page).to have_css("input[src*='like_empty-']")
      expect(page).to have_content('0 likes')
      expect(picture.likes.count).to eq(0)
    end
  end

  describe 'Comment form on Show page' do
    let(:picture) { create(:picture, category: category) }

    before do
      sign_in user
      visit category_picture_path(category_category_name: category.category_name, id: picture.id)
    end

    it 'User can leave comment on the picture', js: true do
      expect(page).to have_content('0 COMMENTS')
      expect(picture.comments.count).to eq(0)
      within('#comment-form') do
        fill_in('comment[body]', with: 'Test comment')
        click_on('Add Comment')
      end
      expect(page).to have_content('1 COMMENT')
      expect(picture.comments.count).to eq(1)

    end
  end
end