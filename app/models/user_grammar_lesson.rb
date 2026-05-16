class UserGrammarLesson < ApplicationRecord
  belongs_to :user
  belongs_to :grammar_lesson
end
