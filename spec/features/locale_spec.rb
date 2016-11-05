require 'rails_helper'

describe 'locale for first time visit' do
  it 'should be detected automatically by browser language' do
    page.driver.header 'Accept-Language', 'en'
    visit root_path
    expect(I18n.locale).to eq(:en)
  end
end

describe 'locale change for non-registered/loggedin users', type: :feature do
  before(:each) { visit root_path }

  it 'should have change locale links' do
    expect(page).to have_content 'Eng'
    expect(page).to have_content 'Рус'
  end

  it 'should change locale to eng' do
    within("footer") { click_link 'Eng' }
    expect(I18n.locale).to be(:en)
  end

  it 'should change locale to rus' do
    within("footer") { click_link 'Рус' }
    expect(I18n.locale).to be(:ru)
  end
end

describe 'locale change for registered/loggedin users' do
  let!(:user) { create :user }

  before do
    visit login_path
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t('log_in')
  end

  it 'should change locale on profile page' do
    visit edit_user_path(user)
    select "English", from: I18n.t("simple_form.labels.user.locale")
    click_button I18n.t("helpers.submit.user.update")
    expect(I18n.locale).to be(:en)
  end
end
