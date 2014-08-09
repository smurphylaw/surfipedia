FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "testing123"

    trait :admin do
      role 'admin'
    end

  end
end