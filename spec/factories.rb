FactoryGirl.define do
  factory :card do
    original_text 'Hello'
    translated_text 'Привет'
    review_date Time.now
  end
end
