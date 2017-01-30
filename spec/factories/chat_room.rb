FactoryGirl.define do
  factory :chat_room do
    sequence(:title) { |n| "Test #{n}" }
    user
  end
end