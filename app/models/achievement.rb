class Achievement < ApplicationRecord
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  validates :name, presence: true, uniqueness: true
  validates :condition_key, presence: true
  validates :threshold, presence: true, numericality: { greater_than: 0 }
end
