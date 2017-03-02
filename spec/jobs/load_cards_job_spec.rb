require 'rails_helper'
require 'spec_helper'

RSpec.describe LoadCardsJob, type: :job do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  fake_html = <<-EOS
    <html>
      <div>
        <a>I am original</a>
        <b>I am translated</b>
      </div>
      <div>
        <a>I am very original</a>
        <b>I am very translated</b>
      </div>
    </html>
    EOS

  before(:each) do
    stub_request(:get, 'http://find_words.test').to_return(status: 200, body: fake_html)
    LoadCardsJob.perform_now(user, 'http://find_words.test', 'a', 'b', deck.id)
  end

  it 'create new card' do
    expect(Card.count).to eq(2)
  end

  it 'should create cards with correct translated text' do
    expect(Card.first.translated_text).to eq('I am translated')
  end

  it 'should create cards with correct translated text' do
    expect(Card.first.original_text).to eq('I am original')
  end

  it 'should create cards with correct translated text' do
    expect(Card.last.translated_text).to eq('I am very translated')
  end

  it 'should create cards with correct translated text' do
    expect(Card.last.original_text).to eq('I am very original')
  end
end
