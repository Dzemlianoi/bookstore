# frozen_string_literal: true

FactoryGirl.define do
  factory :delivery do
    title { "#{FFaker::Lorem.word} delivery" }
    price 30.02
    optimistic_days 1
    pesimistic_days 5

    trait :invalid do
      title nil
    end
  end
end
