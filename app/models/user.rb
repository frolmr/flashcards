class User < ActiveRecord::Base
  include PublicActivity::Common

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :locale, presence: true


  def find_current_deck
    decks.find_by(current: true) || self
  end

  def self.notify_pending_cards
    User.joins(:cards).merge(Card.expires).distinct.each do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
