class QuizQuestion < ApplicationRecord
  LEVELS = %w[beginner intermediate advanced].freeze

  scope :by_level, ->(level) { where(level: level) }

  validates :question, presence: true
  validates :options, presence: true
  validates :correct_index, presence: true
  validates :level, inclusion: { in: LEVELS }
end
