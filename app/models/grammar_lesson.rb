class GrammarLesson < ApplicationRecord
  has_many :grammar_rules, dependent: :destroy
  has_many :user_grammar_lessons, dependent: :destroy

  LEVELS = %w[beginner intermediate advanced classical].freeze

  scope :by_level, ->(level) { where(level: level).order(:position) }

  validates :title, presence: true
  validates :level, inclusion: { in: LEVELS }
end
