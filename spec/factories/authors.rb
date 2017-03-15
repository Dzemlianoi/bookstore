FactoryGirl.define do
  factory :author do
    name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }

    trait :invalid do
      name nil
    end
  end
end