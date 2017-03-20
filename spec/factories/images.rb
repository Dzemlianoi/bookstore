FactoryGirl.define do
  factory :image do
    path do
      my_path = File.join(Rails.root, 'spec/files/test_book.jpg')
      Rack::Test::UploadedFile.new(my_path)
    end
  end
end