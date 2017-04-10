# frozen_string_literal: true

FactoryGirl.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
    price 100.00
    category
    publication_year 1300
    authors { create_list :author, 2 }
    book_dimension { create :book_dimension }

    trait :invalid do
      name nil
    end

    trait :long_description do
      description { FFaker::CheesyLingo.paragraph }
    end
  end
end
