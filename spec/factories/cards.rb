FactoryGirl.define do
  factory :card do
    card_number 123456789012
    cvv 123
    expire_date { "#{rand(1..28)}/#{rand{17..21}}" }
    name FFaker::Name.name
  end
end
