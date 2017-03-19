FactoryGirl.define do
  factory :card do
    card_number 1234567890123456
    cvv 123
    expire_date '11/22'
    name FFaker::Name.name
  end
end
