class CreateQuizQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :quiz_questions do |t|
      t.text :question
      t.jsonb :options
      t.integer :correct_index
      t.string :level
      t.string :category

      t.timestamps
    end
  end
end
