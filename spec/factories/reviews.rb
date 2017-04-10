# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    name 'Good'
    comment_text 'Perfect book'
    rating 4
    user_id { create(:user).id }
    book_id { create(:book).id }

    trait :invalid do
      title nil
    end
  end
end
