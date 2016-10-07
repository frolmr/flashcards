require 'rails_helper'

describe "Deck", type: :feature do
  let!(:user) { create :user }
  let!(:deck1) { create :deck, user: user }
  let!(:deck2) { create :deck, user: user }

  before(:each) do
    visit login_path
    fill_in "Email", with: "test@test.com"
    fill_in "Пароль", with: "foobar"
    click_button "Войти"
    visit "/decks/#{deck1.id}/edit"
    check 'deck_current'
    click_button 'Сохранить колоду'
  end

  it 'should save successful' do
    expect(page).to have_content 'Колода успешно обновлена'
  end

  it 'deck1 should become current' do
    expect(page).to have_content "Текущая колода: #{deck1.name}"
  end

  it 'deck2 should NOT become current' do
    expect(page).not_to have_content "Текущая колода: #{deck2.name}"
  end
end