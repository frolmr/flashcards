require 'rails_helper'

RSpec.describe Card, type: :model do
  it "is valid with valid attributes" do
    expect(Card.new(original_text: 'hello', translated_text: 'salut')).to be_valid
  end

  it "is not valid without original text" do
    expect(Card.new(original_text: '', translated_text: 'salut')).to_not be_valid
  end

  it "is not valid without translated_text" do
    expect(Card.new(original_text: 'hello', translated_text: '')).to_not be_valid
  end
end
