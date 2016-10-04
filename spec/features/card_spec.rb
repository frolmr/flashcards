require 'rails_helper'

describe 'card checking', type: :feature do
  user = FactoryGirl.create(:user)
  let!(:card) { create(:card) }

  before(:each) do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Пароль", with: user.password
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

  it 'should NOT approve the correct translation' do
    fill_in 'card_original_text', with: 'Прюэт'
    click_button 'Проверить'
    expect(page).to have_content 'Не правильно!'
  end
end
