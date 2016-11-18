require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe Card, type: :model do
  subject { described_class.new(original_text: 'hello my Friend', translated_text: 'привет, мой друг') }

  it 'method set_review_date works correctly' do
    expect(subject.send(:set_review_date).to_i / 1000).to eq(Time.now.to_i / 1000)
  end

  it 'has correct word preprocessor' do
    expect(subject.send(:word_processing, 'HeLlO, my Friend!')).to eq('hellomyfriend')
    expect(subject.send(:word_processing, 'HouSe !')).to_not eq('house!')
  end

  it 'method card_check works correctly' do
    expect(subject.card_check('HelLO mY. FrIenD?!')).to eq(0)
    expect(subject.card_check('HelLO mY. FrenD?!')).to eq(1)
    expect(subject.card_check('hello mu Friend')).to_not eq(0)
  end
end
