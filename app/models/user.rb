class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  private

  def downcase_email
    self.email = email.downcase
  end
end
