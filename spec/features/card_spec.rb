require 'rails_helper'

describe 'card checking', type: :feature do
  let!(:card) { create(:card) }

  before do
    visit root_path
    fill_in 'card_original_text', with: 'Hello'
    click_button 'Проверить'
  end

  it 'should check the translation' do
    expect(page).to have_content 'Правильно!'
  end
end
