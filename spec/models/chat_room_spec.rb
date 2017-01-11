require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  before { @chat_room = build(:chat_room) }

  subject { @chat_room }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe 'when title is not present' do
    before { @chat_room.title = ' ' }

    it { should_not be_valid }
  end

  describe 'when user reference is not present' do
    before { @chat_room.user = nil }

    it { should_not be_valid }
  end

  describe 'when title is too long' do
    before { @chat_room.title = 'a' * 21 }

    it { should_not be_valid }
  end

  describe 'when title is too short' do
    before { @chat_room.title = 'a' }

    it { should_not be_valid }
  end

  describe 'when chat room title is already taken' do
    before do
      chat_room_with_same_name = @chat_room.dup
      chat_room_with_same_name.title = @chat_room.title.upcase
      chat_room_with_same_name.save
    end

    it { should_not be_valid }
  end
end
