require 'rails_helper'

describe "Deck", type: :feature do
  let!(:user) { create :user }
  let!(:deck1) { create :deck, user: user }
  let!(:deck2) { create :deck, user: user }

  before(:each) do
    visit login_path
    fill_in I18n.t('simple_form.labels.user.email'), with: "test@test.com"
    fill_in I18n.t('simple_form.labels.user.password'), with: "foobar"
    click_button I18n.t('log_in')
    visit edit_deck_path(deck1)
    check 'deck_current'
    click_button I18n.t('helpers.submit.deck.update')
  end

  it 'should save successful' do
    expect(page).to have_content I18n.t('deck_update_flash')
  end

  it 'deck1 should become current' do
    expect(page).to have_content I18n.t('decks_list_current') + " #{deck1.name}"
  end

  it 'deck2 should NOT become current' do
    expect(page).not_to have_content I18n.t('decks_list_current') + " #{deck2.name}"
  end
end
