class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_save :set_current

  def set_current
    if current
      user.decks.update_all(current: false)
      self.current = true
    end
  end
end
