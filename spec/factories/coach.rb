FactoryGirl.define do
  factory :coach do
    sequence(:email) { |n| "coach#{n}@school.com" }
    password "password"
    password_confirmation "password"
  end
end
