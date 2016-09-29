FactoryGirl.define do
  factory :user do
    email 'user@test.ru'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :card do
    original_text 'Hello'
    translated_text 'Привет'
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.png')) }
    review_date Time.now
    user
  end
end
