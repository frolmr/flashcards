FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :deck do
    sequence(:name) { |n| "test#{n}" }
    current false
  end

  factory :card do
    deck
    user
    original_text 'Hello'
    translated_text 'Привет'
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.png')) }
    review_date Time.now
  end
end
