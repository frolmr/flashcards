class StaticPageController < ApplicationController
  def home
    if current_user
      @random_card = current_user.find_current_deck.cards.expires.sample || current_user.cards.sample
    end
  end

  def check
    @card = Card.find(params[:card][:card_id])
    if @card.card_check(params[:card][:original_text])
      @card.success
      flash[:success] = "Правильно!"
    else
      @card.check_fail
      flash[:danger] = "Не правильно!"
    end
    redirect_to root_path
  end
end
