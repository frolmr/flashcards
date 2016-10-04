FactoryGirl.define do
  factory :user do
    email 'fuck@you.ru'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :deck do
    user
    name 'trash'
    current true
  end

  factory :card do
    user
    deck
    original_text 'Hello'
    translated_text 'Привет'
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.png')) }
    review_date Time.now
  end
end
