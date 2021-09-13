# frozen_string_literal: true

FactoryBot.define do
  factory :advertisement do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    status { 'draft' }
    category
    user

    trait :draft do
      status { 'draft' }
    end

    trait :pending_review do
      status { 'pending_review' }
    end

    trait :approved do
      status { 'approved' }
    end

    trait :rejected do
      status { 'rejected' }
    end

    trait :published do
      status { 'published' }
    end

    trait :archived do
      status { 'archived' }
    end
  end
end
