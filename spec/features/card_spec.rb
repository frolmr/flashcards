require 'rails_helper'

describe 'card checking', type: :feature do
  let!(:card) { create :card }

  before(:each) do
    visit login_path
    fill_in "Email", with: "test@test.com"
    fill_in "Пароль", with: "foobar"
    click_button "Войти"
  end

  it 'should have image' do
    visit root_path
    expect(page).to have_css("img[src*='test_image.png']")
  end

  it 'should approve the correct translation' do
    fill_in 'card_original_text', with: 'Hello'
    click_button 'Проверить'
    expect(page).to have_content 'Правильно!'
  end

  it 'should approve with misspelling' do
    fill_in 'card_original_text', with: 'Helo'
    click_button 'Проверить'
    expect(page).to have_content "Вы, вероятно, опечатались?!"
  end

  it 'should NOT approve the incorrect translation' do
    fill_in 'card_original_text', with: 'Прюэт'
    click_button 'Проверить'
    expect(page).to have_content 'Не правильно!'
  end
end
