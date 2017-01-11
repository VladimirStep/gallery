require 'rails_helper'

RSpec.describe Message, type: :model do
  before { @message = build(:message) }

  subject { @message }

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:chat_room_id) }
  it { should be_valid }

  describe 'when body is not present' do
    before { @message.body = ' ' }

    it { should_not be_valid }
  end

  describe 'when body is too long' do
    before { @message.body = 'a' * 2001 }

    it { should_not be_valid }
  end

  describe 'when body is too short' do
    before { @message.body = 'a' }

    it { should_not be_valid }
  end

  describe 'when user reference is not present' do
    before { @message.user = nil }

    it { should_not be_valid }
  end

  describe 'when chat room reference is not present' do
    before { @message.chat_room = nil }

    it { should_not be_valid }
  end
end
