class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_progress, dependent: :destroy
  has_many :user_letters, dependent: :destroy
  has_many :letters, through: :user_letters
  has_many :user_words, dependent: :destroy
  has_many :words, through: :user_words
  has_many :user_achievements, dependent: :destroy
  has_many :achievements, through: :user_achievements
  has_many :user_grammar_lessons, dependent: :destroy
  has_many :completed_grammar_lessons, through: :user_grammar_lessons, source: :grammar_lesson

  after_create :create_progress

  ROLES  = %w[learner admin].freeze
  LEVELS = %w[beginner intermediate advanced].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def create_progress
    UserProgress.create(user: self, streak_days: 0, study_time_minutes: 0)
  end
end
