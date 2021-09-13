# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    password { 'Abc123' }
    role { 'user' }

    trait :admin do
      role { 'admin' }
    end

    trait :user do
      role { 'user' }
    end
  end
end
