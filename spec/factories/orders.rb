# frozen_string_literal: true

FactoryGirl.define do
  factory :order do
    user
    track_number '1234567'
    trait :with_items do
      order_items { create_list(:order_item, 2) }
    end

    trait :checkout_page do
      order_items { create_list(:order_item, 2) }
      addresses { create :address, kind: 'shipping' }
      addresses { create :address, kind: 'billing' }
      delivery
      card
    end
  end
end
