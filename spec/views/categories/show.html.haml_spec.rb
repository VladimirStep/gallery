require 'rails_helper'

RSpec.describe 'categories/show.html.haml', type: :view do
  before { assign(:category, create(:category, category_name: 'Ruby')) }

  it 'displays category name and pictures' do
    render

    expect(rendered).to have_content('Ruby')
  end
end
