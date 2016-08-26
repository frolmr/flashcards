class StaticPageController < ApplicationController
  def home
    @random_card = Card.expires.sample ? Card.expires.sample : Card.all.sample
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
