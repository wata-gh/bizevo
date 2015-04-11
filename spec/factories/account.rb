FactoryGirl.define do

  factory :account, :class => Account do
    name 'test'
    surname 'test'
    sequence(:email)   { |n| "test_#{n}@bizevo.net" }
    password 'abcd1234'
    password_confirmation 'abcd1234'
    role 'user'
  end
end
