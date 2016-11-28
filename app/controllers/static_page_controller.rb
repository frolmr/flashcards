class StaticPageController < ApplicationController
  def home
    if current_user
      @random_card = current_user.find_current_deck.cards.expires.sample || current_user.cards.sample
      respond_to do |format|
        format.html
        format.json do
          render json: {
            id: @random_card.id,
            image: @random_card.image.url,
            translated_text: @random_card.translated_text,
            flash_key: flash.keys.first.to_s,
            flash_message: flash[flash.keys.first.to_s]
          }
        end
      end
    end
  end

  def check
    @card = Card.find(params[:card][:id])
    answer_time = params[:card][:timer].to_i
    if @card.card_check(params[:card][:original_text]).zero?
      CardAttrUpdater.new(@card, answer_time).check_result
      flash[:success] = t('.success')
    elsif @card.card_check(params[:card][:original_text]) == 1
      CardAttrUpdater.new(@card, answer_time).check_result
      flash[:warning] = t('.warning', translated_text: @card.translated_text, original_text: @card.original_text, card_original_text: params[:card][:original_text])
    else
      CardAttrUpdater.new(@card, answer_time).check_result(true)
      flash[:danger] = t('.danger')
    end
    redirect_to root_path
  end
end
