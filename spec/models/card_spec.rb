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
end
