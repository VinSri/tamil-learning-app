class CreateUserGrammarLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :user_grammar_lessons do |t|
      t.references :user, null: false, foreign_key: true
      t.references :grammar_lesson, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
    add_index :user_grammar_lessons, [:user_id, :grammar_lesson_id], unique: true
  end
end
