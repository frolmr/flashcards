FactoryGirl.define do
  factory :user do
    email 'test@user.ru'
    password 'foobar'
  end

  factory :card do
    original_text 'Hello'
    translated_text 'Привет'
    review_date Time.now
    user
  end
end
