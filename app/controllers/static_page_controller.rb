class StaticPageController < ApplicationController
  def home
    @random_card = Card.expires.sample
  end

  def check
    @card = Card.find(params[:card][:card_id])
    if @card.original_text == params[:card][:original_text]
      redirect_to root_path
      flash[:success] = "Правильно!"
      @card.add_review_date
      @card.save
    else
      redirect_to root_path
      flash[:danger] = "Не правильно!"
    end
  end
end
