FactoryGirl.define do
  factory :book_dimension do
    height { rand(0.50...20.00) }
    width { rand(0.50...20.00) }
    depth { rand(0.50...20.00) }
  end
end