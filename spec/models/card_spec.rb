require 'rails_helper'

RSpec.describe Card, type: :model do
  subject { described_class.new(original_text: 'hello my Friend', translated_text: 'привет, мой друг') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without original text" do
    subject.original_text = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without translated_text" do
    subject.translated_text = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with same words' do
    subject.translated_text = ' Hello, mY fRiEnD!!!'
    expect(subject).to_not be_valid
  end

  it 'has correct review date after creation' do
    subject.save
    expect(subject.review_date).to_not be_nil
  end

  it 'method add_review_date works correctly' do
    expect(subject.add_review_date).to eq(Time.now.change(usec: 0) + 3.days)
    expect(subject.add_review_date).to_not eq(Time.now.change(usec: 0))
  end

  it 'has correct word preprocessor' do
    expect(subject.send(:word_processing, 'HeLlO, my Friend!')).to eq('hellomyfriend')
    expect(subject.send(:word_processing, 'HouSe !')).to_not eq('house!')
  end

  it 'method card_check works correctly' do
    expect(subject.card_check('HelLO mY. FrIenD?!')).to be true
    expect(subject.card_check('hello mu Friend')).to be false
  end
end
