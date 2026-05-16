class ReadingPassage < ApplicationRecord
  LEVELS = %w[beginner intermediate advanced classical].freeze

  scope :by_level, ->(level) { where(level: level) }

  validates :title, presence: true
  validates :content, presence: true
  validates :level, inclusion: { in: LEVELS }
end
