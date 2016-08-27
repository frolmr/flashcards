require 'rails_helper'

describe 'card checking', type: :feature do
  let!(:card) { create(:card) }

  before(:each) do
    visit root_path
  end

  it 'should approve the correct translation' do
    fill_in 'card_original_text', with: 'Hello'
    click_button 'Проверить'
    expect(page).to have_content 'Правильно!'
  end

  it 'should NOT approve the correct translation' do
    fill_in 'card_original_text', with: 'Прюэт'
    click_button 'Проверить'
    expect(page).to have_content 'Не правильно!'
  end
end
