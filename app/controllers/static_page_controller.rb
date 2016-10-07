class StaticPageController < ApplicationController
  def home
    @random_card = current_user.find_current_deck.cards.sample if current_user
  end

  def check
    @card = Card.find(params[:card][:card_id])
    if @card.card_check(params[:card][:original_text])
      @card.success
      flash[:success] = "Правильно!"
    else
      flash[:danger] = "Не правильно!"
    end
    redirect_to root_path
  end
end
