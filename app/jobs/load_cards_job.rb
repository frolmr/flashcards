class LoadCardsJob < ApplicationJob
  queue_as :default

  def perform(user, link, original_word_tag, translated_word_tag, deck_id)
    result = {}
    page = Nokogiri::HTML(open(link))
    page.css(original_word_tag).each do |word|
      result[word.text] = word.parent.css(translated_word_tag).text
      Card.create(original_text: word.text, translated_text: word.parent.css(translated_word_tag).text, deck_id: deck_id, user: user)
    end
    result
  end
end
