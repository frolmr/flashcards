require 'rails_helper'

describe "SignUp", type: :feature do
  before { visit 'users/new' }

  it 'should register user with correct data' do
    fill_in I18n.t('simple_form.labels.user.email'), with: 'foo@foo.net'
    fill_in I18n.t('simple_form.labels.user.password'), with: 'foobar'
    fill_in I18n.t('simple_form.labels.user.password_confirmation'), with: 'foobar'
    click_button I18n.t('helpers.submit.user.create')
    expect(page).to have_content I18n.t("dashboard.users.create.success")
  end

  it 'should NOT register user with incorrect data' do
    fill_in I18n.t('simple_form.labels.user.email'), with: 'foo@foo.net'
    fill_in I18n.t('simple_form.labels.user.password'), with: 'foobar'
    fill_in I18n.t('simple_form.labels.user.password_confirmation'), with: 'barfoo'
    click_button I18n.t('helpers.submit.user.create')
    expect(page).to have_content I18n.t("dashboard.users.create.danger")
  end
end

describe 'LogIn', type: :feature do
  let!(:user) { create(:user) }
  before { visit login_path }

  it 'should authenticate with correct data' do
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t("log_in")
    expect(page).to have_content I18n.t("home.user_sessions.create.success")
  end

  it 'should NOT authenticate with incorrect data' do
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: 'barfoo'
    click_button I18n.t("log_in")
    expect(page).to have_content I18n.t("home.user_sessions.create.danger")
  end
end

describe 'LogOut', type: :feature do
  let!(:user) { create(:user) }
  before do
    visit login_path
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t("log_in")
  end

  it 'should logout by clicking link' do
    click_link I18n.t("log_out")
    expect(page).to have_content I18n.t("home.user_sessions.destroy.success")
  end
end
