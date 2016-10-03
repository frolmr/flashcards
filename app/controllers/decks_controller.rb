class DecksController < ApplicationController
  before_action :get_deck, only: [:edit, :update, :destroy]

  def index
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(deck_params)
    @deck.user_id = current_user.id
    if @deck.save
      flash[:success] = "Новая колода добавлена"
      redirect_to decks_path
    else
      flash.now[:danger] = "Что-то пошло не так!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @deck.update_attributes(deck_params)
      flash[:success] = "Колода успешно обновлена"
      redirect_to decks_path
    else
      render 'edit'
    end
  end

  def destroy
    @deck.destroy
    flash[:success] = "Колода удалена"
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :current)
  end

  def get_deck
    @deck = Deck.find(params[:id])
  end
end
