require 'rails_helper'

describe Category do
  before do
    @category = Category.new(category_name: 'Tits')
  end

  subject { @category }

  it { should respond_to(:category_name) }

  it { should be_valid }

  describe "when category name is not present" do
    before { @category.category_name = " " }

    it { should_not be_valid }
  end

  describe "when category name is too long" do
    before { @category.category_name = "a" * 21 }

    it { should_not be_valid }
  end

  describe "when category name is already taken" do
    before do
      category_with_same_name = @category.dup
      category_with_same_name.category_name = @category.category_name.upcase
      category_with_same_name.save

      it { should_not be_valid }
    end
  end
end