class StaticPageController < ApplicationController
  def home
    if current_user
      # @random_card = Card.expires.where(user_id: current_user.id).sample || Card.where(user_id: current_user.id).sample
      @random_card = current_user.cards.expires.sample || current_user.cards.sample
    end
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
