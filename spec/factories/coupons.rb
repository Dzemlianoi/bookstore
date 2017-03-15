FactoryGirl.define do
  factory :coupon do
    code { rand(1000000).to_s }
    discount 10

    trait :used do
      order
    end
  end
end