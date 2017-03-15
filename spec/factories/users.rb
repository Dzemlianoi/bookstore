FactoryGirl.define do
  factory :user do
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)

    email { FFaker::Internet.email }
    password 'testpass'
    password_confirmation 'testpass'

    trait :invalid do
      email nil
    end

    trait :admin do
      role_name 'admin'
    end
  end
end