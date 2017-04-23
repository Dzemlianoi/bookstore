# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    name { FFaker::Book.genre }
    trait :invalid do
      name nil
    end
  end
end
