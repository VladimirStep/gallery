FactoryGirl.define do
  sequence :url do |n|
    "/path/#{n}"
  end

  factory :event do
    url
    user
  end
end