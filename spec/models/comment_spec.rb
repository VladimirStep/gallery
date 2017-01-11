require 'rails_helper'

RSpec.describe Comment, type: :model do
  before { @comment = build(:comment) }

  subject { @comment }

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:picture_id) }
  it { should be_valid }

  describe 'when body is not present' do
    before { @comment.body = ' ' }

    it { should_not be_valid }
  end

  describe 'when body is too long' do
    before { @comment.body = 'a' * 2001 }

    it { should_not be_valid }
  end

  describe 'when body is too short' do
    before { @comment.body = 'a' }

    it { should_not be_valid }
  end

  describe 'when user reference is not present' do
    before { @comment.user = nil }

    it { should_not be_valid }
  end

  describe 'when picture reference is not present' do
    before { @comment.picture = nil }

    it { should_not be_valid }
  end
end
