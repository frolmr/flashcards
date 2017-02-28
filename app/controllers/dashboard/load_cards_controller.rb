class Dashboard::LoadCardsController < ApplicationController
  def new; end

  def load_word_pairs
    result = LoadCardsJob.perform_now(current_user, params[:link], params[:original_word_tag], params[:translated_word_tag], params[:deck_id])
    respond_to do |format|
      format.json do
        render json: {
          result: result
        }
      end
    end
  end
end
