require 'rails_helper'

RSpec.describe Site, type: :model do
  before { @site = build(:site) }

  subject { @site }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should be_valid }

  describe 'when name is not present' do
    before { @site.name = ' ' }

    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @site.name = 'a' * 16 }

    it { should_not be_valid }
  end

  describe 'when name is too short' do
    before { @site.name = 'a' }

    it { should_not be_valid }
  end

  describe 'when address is not present' do
    before { @site.address = ' ' }

    it { should_not be_valid }
  end

  describe 'when address is too long' do
    before { @site.address = 'a' * 254 }

    it { should_not be_valid }
  end

  describe 'when address is not correct' do
    before { @site.address = 'asdf' }

    it { should_not be_valid }
  end

  describe 'when address is correct' do
    before { @site.address = 'http://google.com' }

    it { should be_valid }
  end

  describe 'when site name is already taken' do
    before do
      site_with_same_name = @site.dup
      site_with_same_name.name = @site.name.upcase
      site_with_same_name.save
    end

    it { should_not be_valid }
  end
end
