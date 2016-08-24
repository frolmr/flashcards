class Card < ActiveRecord::Base
  scope :expires, -> { where('review_date <= ?', Date.today) }

  before_validation :add_review_date, on: :create

  validates :original_text, :translated_text, :review_date, presence: true

  after_validation :compare_words

  def add_review_date
    self.review_date = Time.now.change(usec: 0) + 3.days
  end

  def card_check(text)
    word_processing(original_text) == word_processing(text)
  end

  def success
    add_review_date
    save
  end

  private

  def word_processing(word)
    word.gsub(/\W/, '').downcase if word
  end

  def compare_words
    if word_processing(original_text) == word_processing(translated_text)
      errors.add(:original_text, "оригинальный текст совпадает с переводом")
      errors.add(:translated_text, "перевод совпадает с оригинальным текстом")
    end
  end
end
