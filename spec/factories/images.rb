FactoryGirl.define do
  factory :image do
    path do
      path = File.join(Rails.root, 'spec/files/test_book.jpg')
      Rack::Test::UploadedFile.new(path)
    end
    association :imageable, factory: :book
  end
end