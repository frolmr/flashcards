require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe Card, type: :model do
  subject { described_class.new(original_text: 'hello my Friend', translated_text: 'привет, мой друг') }

  it 'method set_review_date works correctly' do
    expect(subject.set_review_date.to_i / 100).to eq(Time.now.to_i / 100)
  end

  it 'has correct word preprocessor' do
    expect(subject.send(:word_processing, 'HeLlO, my Friend!')).to eq('hellomyfriend')
    expect(subject.send(:word_processing, 'HouSe !')).to_not eq('house!')
  end

  it 'method card_check works correctly' do
    expect(subject.card_check('HelLO mY. FrIenD?!')).to be true
    expect(subject.card_check('hello mu Friend')).to be false
  end

  context 'has correct work of increase_review_date method' do
    it 'should increase the review date' do
      expect(subject.increase_review_date.to_i).to be > Time.now.to_i
      expect(subject.increase_review_date.to_i).to_not be <= Time.now.to_i
    end

    it 'should move card to another box' do
      expect{subject.increase_review_date}.to change{subject.box}.by(1)
    end
  end

  context 'has correct work of decrease_review_date method' do
    it 'should refresh the box number to one' do
      expect{subject.decrease_review_date}.to change{subject.box}.to(1)
    end

    it 'should set the review date to 12 hours after current time' do
      expect(subject.decrease_review_date.to_i / 100).to eq((Time.now + 12.hours).to_i / 100)
    end
  end

  context 'has correct work of check_fail method' do
    it 'should increment amount of bad_tries' do
      expect{subject.check_fail}.to change{subject.bad_tries}.from(0).to(1)
    end

    it 'should refresh the bad_tries to 0 after three bad tries' do
      subject.bad_tries = 2
      expect{subject.check_fail}.to change{subject.bad_tries}.to(0)
    end
  end
end
