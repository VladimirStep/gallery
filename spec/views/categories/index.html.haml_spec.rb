require 'rails_helper'

RSpec.describe 'categories/index.html.haml', type: :view do
  before do
    assign(:categories, [
        create(:category, category_name: 'Ruby'),
        create(:category, category_name: 'Cats')
    ])
  end

  it 'displays all categories' do
    render

    expect(rendered).to have_content('RUBY')
    expect(rendered).to have_content('CATS')
  end
end
