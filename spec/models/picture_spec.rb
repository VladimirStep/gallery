require 'rails_helper'

RSpec.describe Picture, type: :model do
  before do
    ImageUploader.enable_processing = true
    @picture = build(:picture)
  end

  after do
    ImageUploader.enable_processing = false
    @picture.remove_image!
  end

  subject { @picture }

  it { should respond_to :category_id }
  it { should respond_to :likes_count }
  it { should respond_to :image }
  it { should be_valid }

  context 'the thumb version' do
    it 'scales down the image to to fit within 128 by 128 pixels' do
      expect(@picture.image.thumb).to be_no_larger_than(128, 128)
    end
  end

  it 'makes the image readable and not executable' do
    expect(@picture.image).to have_permissions(0644)
  end

  it 'has the correct format' do
    expect(@picture.image).to be_format('JPEG')
  end

  describe 'when file is not an image' do
    before { @picture.image = File.open(Rails.root.join('spec', 'fixtures', 'test.mp4')) }

    it { should_not be_valid }
  end

  describe 'when image is invalid' do
    before { @picture.image = File.open(Rails.root.join('spec', 'fixtures', 'invalid_image.jpg')) }

    it { should_not be_valid }
  end

  describe 'when category reference is not present' do
    before { @picture.category_id = nil }

    it { should_not be_valid }
  end
end
