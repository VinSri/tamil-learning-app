class Word < ApplicationRecord
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words

  CATEGORIES = %w[basics numbers colors family food places body nature animals time verbs classical].freeze

  scope :by_category, ->(cat) { where(category: cat).order(:english) }

  validates :tamil, presence: true
  validates :english, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
