class CardsController < ApplicationController
  before_action :get_card, only: [:edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)
    @card.user_id = current_user.id
    if @card.save
      flash[:success] = "Новая карточка создана"
      redirect_to cards_path
    else
      flash.now[:danger] = "Что-то пошло не так!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @card.update_attributes(card_params)
      flash[:success] = "Карточка успешно обновлена"
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = "Карточка удалена"
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :remote_image_url, :deck_id)
  end

  def get_card
    @card = Card.find(params[:id])
  end
end
