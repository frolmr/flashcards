class Dashboard::DecksController < ApplicationController
  include CreateAction
  include PageVisitActivity

  before_action :get_deck, only: [:edit, :update, :destroy]
  after_action :track_page_visit, only: [:index, :new, :edit]

  def index
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(deck_params)
    create_new_item(@deck)
  end

  def edit; end

  def update
    if @deck.update_attributes(deck_params)
      flash[:success] = t('.success')
      redirect_to decks_path
    else
      render 'edit'
    end
  end

  def destroy
    @deck.destroy
    flash[:success] = t('.success')
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
