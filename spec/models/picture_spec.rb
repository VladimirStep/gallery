require 'rails_helper'

describe Picture do
  before do
    @picture = Picture.new(picture_name: "cool girl")
  end

  subject { @picture }

  it { should respond_to :picture_name }
  it { should respond_to :image }

  it { should be_valid }

  describe "when picture name is not present" do
    before { @picture.picture_name = " " }

    it { should_not be_valid }
  end

  # TODO Make test for image field in Picture

  # describe "when image is not present" do
  #   before { @picture.image = " " }

  #   it { should_not be_valid }
  # end
end
