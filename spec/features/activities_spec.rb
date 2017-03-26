require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe ActivitiesController do
  describe 'User' do
    context 'on create action' do
      before do
        visit new_user_path
        fill_in I18n.t('simple_form.labels.user.email'), with: 'foo@foo.net'
        fill_in I18n.t('simple_form.labels.user.password'), with: 'foobar'
        fill_in I18n.t('simple_form.labels.user.password_confirmation'), with: 'foobar'
        click_button I18n.t('helpers.submit.user.create')
      end

      it 'should create activity' do
        visit activities_path
        expect(page).to have_content('New user foo@foo.net was created')
      end
    end

    context 'on log-in' do
      let!(:user) { create :user }

      before do
        login
      end

      it 'should create activity' do
        visit activities_path
        expect(page).to have_content('User test@test.com logged in via simple auth')
      end
    end
  end

  describe 'Cards' do
    context 'on create action' do
      let!(:user) { create :user }
      let!(:deck) { create :deck, user: user }

      before do
        login
        visit new_card_path
        fill_in I18n.t('simple_form.labels.card.original_text'), with: 'test'
        fill_in I18n.t('simple_form.labels.card.translated_text'), with: 'тест'
        select "test1", from: I18n.t("simple_form.labels.card.deck")
        click_button I18n.t('helpers.submit.card.create')
      end

      it 'should create activity' do
        visit activities_path
        expect(page).to have_content("New card \"test - тест\" was created")
      end
    end

    context 'on review action' do
      let!(:card) { create :card }
      before(:each) do
        login
      end

      it 'should create activity with successfull status' do
        fill_in 'card_original_text', with: 'Hello'
        click_button I18n.t("check_button_title")
        visit activities_path
        expect(page).to have_content("Card \"#{card.original_text} - #{card.translated_text}\" was reviewed successfull")
      end

      it 'should create activity with warning' do
        fill_in 'card_original_text', with: 'Helo'
        click_button I18n.t("check_button_title")
        visit activities_path
        expect(page).to have_content("Card \"#{card.original_text} - #{card.translated_text}\" was reviewed with warning")
      end
    end
  end

  describe 'Navigation' do
    let!(:card) { create :card }

    before(:each) do
      login
    end

    it 'should create activity on home page visit' do
      visit activities_path
      expect(page).to have_content("User test@test.com visited static_page.home page")
    end

    it 'should create activity on Card#index page visit' do
      visit cards_path
      visit activities_path
      expect(page).to have_content("User test@test.com visited cards.index page")
    end

    it 'should create activity on Card#new page visit' do
      visit new_card_path
      visit activities_path
      expect(page).to have_content("User test@test.com visited cards.new page")
    end

    it 'should create activity on Deck#index page visit' do
      visit decks_path
      visit activities_path
      expect(page).to have_content("User test@test.com visited decks.index page")
    end

    it 'should create activity on Deck#new page visit' do
      visit new_deck_path
      visit activities_path
      expect(page).to have_content("User test@test.com visited decks.new page")
    end
  end
end
