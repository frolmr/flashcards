require 'spec_helper'

describe "SignUp", type: :feature do
  before { visit 'users/new' }

  it 'should register user with correct data' do
    fill_in "Email", with: 'foo@foo.net'
    fill_in "Пароль", with: 'foobar'
    fill_in "Подтверждение пароля", with: 'foobar'
    click_button "Сохранить"
    expect(page).to have_content "Добавлен новый пользователь"
  end

  it 'should NOT register user with incorrect data' do
    fill_in "Email", with: 'foo@foo.net'
    fill_in "Пароль", with: 'foobar'
    fill_in "Подтверждение пароля", with: 'barfoo'
    click_button "Сохранить"
    expect(page).to have_content "Что-то пошло не так!"
  end
end

describe 'LogIn', type: :feature do
  let!(:user) { create(:user) }
  before { visit login_path }

  it 'should authenticate with correct data' do
    fill_in "Email", with: 'user@test.ru'
    fill_in "Пароль", with: 'foobar'
    click_button "Войти"
    expect(page).to have_content "Успешный вход"
  end

  it 'should NOT authenticate with incorrect data' do
    fill_in "Email", with: 'user@test.ru'
    fill_in "Пароль", with: 'barfoo'
    click_button "Войти"
    expect(page).to have_content "Не удалось войти"
  end
end

describe 'LogOut', type: :feature do
  let!(:user) { create(:user) }
  before do
    visit login_path
    fill_in "Email", with: 'user@test.ru'
    fill_in "Пароль", with: 'foobar'
    click_button "Войти"
  end

  it 'should logout by clicking link' do
    click_link "Выйти"
    expect(page).to have_content "Успешный выход"
  end
end
