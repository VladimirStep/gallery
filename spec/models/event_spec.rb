require 'rails_helper'

RSpec.describe Event, type: :model do
  before { @event = build(:event) }

  subject { @event }

  it { should respond_to(:url) }
  it { should respond_to(:user_id) }
  it { should respond_to(:confirmation) }
  it { should be_valid }

  describe 'when url is not present' do
    before { @event.url = ' ' }

    it { should_not be_valid }
  end

  describe 'when user reference is not present' do
    before { @event.user = nil }

    it { should_not be_valid }
  end

  describe 'when confirmation status is not present' do
    before { @event.confirmation = nil }

    it { should_not be_valid }
  end
end
