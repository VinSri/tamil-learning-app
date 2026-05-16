class NiganduEntry < ApplicationRecord
  validates :sutra_number, presence: true, uniqueness: true
  validates :headword, presence: true

  scope :by_category, ->(cat) { where(category: cat) }
  scope :ordered, -> { order(:sutra_number) }

  def self.categories
    distinct.pluck(:category).compact
  end
end
