FactoryGirl.define do
  factory :delivery do
    title { "#{FFaker::Address.country} delivery" }
    price 30.02
    optimistic_days 1
    pesimistic_days 5

    trait :invalid do
      title nil
    end
  end
end