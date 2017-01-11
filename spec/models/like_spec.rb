require 'rails_helper'

RSpec.describe Like, type: :model do
  before { @like = build(:like) }

  subject { @like }

  it { should respond_to(:picture_id) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe 'when user reference is not present' do
    before { @like.user = nil }

    it { should_not be_valid }
  end

  describe 'when picture reference is not present' do
    before { @like.picture = nil }

    it { should_not be_valid }
  end
end
