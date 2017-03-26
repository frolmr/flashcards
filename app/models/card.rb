class Card < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :deck, required: true

  scope :expires, -> { where('review_date <= ?', Time.now) }

  before_validation :set_review_date, on: :create

  validates :original_text, :translated_text, :e_factor, :repetition, :review_interval, :review_date, :user, presence: true
  validates :e_factor, :repetition, :review_interval, numericality: true

  after_validation :compare_words

  mount_uploader :image, ImageUploader

  def card_check(text)
    DamerauLevenshtein.distance(word_processing(original_text), word_processing(text))
  end

  private

  def set_review_date
    self.review_date = Time.now
  end

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
