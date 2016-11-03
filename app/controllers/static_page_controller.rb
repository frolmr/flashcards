class StaticPageController < ApplicationController
  def home
    if current_user
      @random_card = current_user.find_current_deck.cards.expires.sample || current_user.cards.sample
    end
  end

  def check
    @card = Card.find(params[:card][:card_id])
    if @card.card_check(params[:card][:original_text]).zero?
      @card.success
      flash[:success] = t('check_successfull_flash')
    elsif @card.card_check(params[:card][:original_text]) == 1
      @card.success
      flash[:warning] = t('check_warning_flash', translated_text: @card.translated_text, original_text: @card.original_text, card_original_text: params[:card][:original_text])
    else
      @card.check_fail
      flash[:danger] = t('check_unsuccessfull_flash')
    end
    redirect_to root_path
  end
end
