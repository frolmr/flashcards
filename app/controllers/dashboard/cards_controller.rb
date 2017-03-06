class Dashboard::CardsController < ApplicationController
  include CreateAction

  before_action :get_card, only: [:edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)
    create_new_item(@card)
  end

  def edit; end

  def update
    if @card.update_attributes(card_params)
      flash[:success] = t('.success')
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:success] = t('.success')
    redirect_to cards_path
  end

  def find_on_flickr
    urls_list = FlickrSearch.new.search_photos_urls(params[:flickr_tag])
    respond_to do |format|
      format.json do
        render json: { list: urls_list }
      end
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :remote_image_url, :deck_id)
  end

  def get_card
    @card = Card.find(params[:id])
  end
end
