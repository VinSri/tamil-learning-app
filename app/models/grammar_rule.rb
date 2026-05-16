class GrammarRule < ApplicationRecord
  belongs_to :grammar_lesson

  validates :rule_text, presence: true
  validates :tamil_example, presence: true
  validates :english_translation, presence: true
end
