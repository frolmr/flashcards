require 'rails_helper'

describe 'card checking', type: :feature do
  let!(:card) { create :card }

  before(:each) do
    visit login_path
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t('log_in')
  end

  it 'should have image' do
    visit root_path
    expect(page).to have_css("img[src*='test_image.png']")
  end

  it 'should approve the correct translation' do
    fill_in 'card_original_text', with: 'Hello'
    click_button I18n.t("check_button_title")
    expect(page).to have_content I18n.t('static_page.check.success')
  end

  it 'should approve with misspelling' do
    check_word = 'Helo'
    fill_in 'card_original_text', with: check_word
    click_button I18n.t("check_button_title")
    expect(page).to have_content I18n.t('static_page.check.warning', translated_text: card.translated_text, original_text: card.original_text, card_original_text: check_word)
  end

  it 'should NOT approve the incorrect translation' do
    fill_in 'card_original_text', with: 'Прюэт'
    click_button I18n.t("check_button_title")
    expect(page).to have_content I18n.t('static_page.check.danger')
  end
end
