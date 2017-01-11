FactoryGirl.define do
  factory :picture do
    category
    image { File.open(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
  end
end
