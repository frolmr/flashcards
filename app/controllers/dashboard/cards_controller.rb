class Dashboard::CardsController < ApplicationController
  include CreateAction
  include PageVisitActivity

  before_action :get_card, only: [:edit, :update, :destroy]
  after_action :track_page_visit, only: [:index, :new, :edit]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)
    create_new_item(@card)
    @card.create_activity :create, activity_type: 'card', owner: current_user
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
    urls_list = Rails.cache.fetch(params[:flickr_tag].to_s, expires_in: 6.hours) { FlickrSearch.new.search_photos_urls(params[:flickr_tag]) }
    current_user.create_activity action: 'find_on_flickr', activity_type: 'api', params: { search_tag: params[:flickr_tag] }, owner: current_user
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
