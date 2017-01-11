FactoryGirl.define do
  factory :message do
    body 'Lorem ip sum'
    user
    chat_room
  end
end