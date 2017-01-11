require 'rails_helper'

RSpec.describe Category, type: :model do
  before { @category = build(:category) }

  subject { @category }

  it { should respond_to(:category_name) }
  it { should be_valid }

  describe 'when category name is not present' do
    before { @category.category_name = ' ' }

    it { should_not be_valid }
  end

  describe 'when category name is too long' do
    before { @category.category_name = 'a' * 21 }

    it { should_not be_valid }
  end

  describe 'when category name is too short' do
    before { @category.category_name = 'a' }

    it { should_not be_valid }
  end

  describe 'when category name is already taken' do
    before do
      category_with_same_name = @category.dup
      category_with_same_name.category_name = @category.category_name.upcase
      category_with_same_name.save
    end

    it { should_not be_valid }
  end
end