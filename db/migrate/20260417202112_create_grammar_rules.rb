class CreateGrammarRules < ActiveRecord::Migration[8.1]
  def change
    create_table :grammar_rules do |t|
      t.references :grammar_lesson, null: false, foreign_key: true
      t.text :rule_text
      t.text :explanation
      t.string :tamil_example
      t.string :english_translation

      t.timestamps
    end
  end
end
