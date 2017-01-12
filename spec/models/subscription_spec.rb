require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before { @subscription = build(:subscription) }

  subject { @subscription }

  it { should respond_to(:user_id) }
  it { should respond_to(:category_id) }
  it { should be_valid }

  describe 'when user reference is not present' do
    before { @subscription.user = nil }

    it { should_not be_valid }
  end

  describe 'when category reference is not present' do
    before { @subscription.category = nil }

    it { should_not be_valid }
  end
end
