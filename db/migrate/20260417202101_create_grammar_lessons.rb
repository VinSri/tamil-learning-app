class CreateGrammarLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :grammar_lessons do |t|
      t.string :title
      t.text :content
      t.string :level
      t.integer :position

      t.timestamps
    end
  end
end
