FactoryGirl.define do
  factory :address do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    address 'Test 12'
    city 'Dnipro'
    zip 49000
    phone '+380967777777'
    country 'AF'
  end

  factory :users_address, parent: :address do
    addressable { create :user }

    trait :shipping do
      kind :shipping
    end

    trait :billing do
      kind :billing
    end

    trait :invalid do
      phone '543234'
      kind :billing
    end
  end

  factory :orders_address, parent: :users_address do
    addressable { create :order }
  end
end
