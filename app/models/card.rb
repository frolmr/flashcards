class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck, required: true

  scope :expires, -> { where('review_date <= ?', Time.now) }

  before_validation :set_review_date, on: :create

  validates :original_text, :translated_text, :review_group, :bad_tries, :review_date, :user, presence: true
  validates :review_group, :bad_tries, numericality: true

  after_validation :compare_words

  mount_uploader :image, ImageUploader

  TODAY = Time.now
  REVIEW_PERIODS = [TODAY, TODAY + 12.hours, TODAY + 3.days, TODAY + 1.week, TODAY + 2.weeks, TODAY + 1.month].freeze

  def set_next_review_group
    if review_group < REVIEW_PERIODS.size - 1
      self.review_group += 1
    end
    set_review_date
  end

  def drop_review_group
    self.review_group = 1
    set_review_date
  end

  def set_review_date
    self.review_date = REVIEW_PERIODS[self.review_group]
  end

  def card_check(text)
    word_processing(original_text) == word_processing(text)
  end

  def success
    set_next_review_group
    save
  end

  def check_fail
    self.bad_tries += 1
    if self.bad_tries == 3
      self.bad_tries = 0
      drop_review_group
    end
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
