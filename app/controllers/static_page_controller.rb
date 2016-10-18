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
      flash[:success] = "Правильно!"
    elsif @card.card_check(params[:card][:original_text]) == 1
      @card.success
      flash[:warning] = "Загаданное слово: #{@card.translated_text}, переводится как #{@card.original_text}, а вы ввели: #{params[:card][:original_text]}. Вы, вероятно, опечатались?!"
    else
      @card.check_fail
      flash[:danger] = "Не правильно!"
    end
    redirect_to root_path
  end
end
