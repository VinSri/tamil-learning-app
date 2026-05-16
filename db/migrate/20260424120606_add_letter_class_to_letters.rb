class AddLetterClassToLetters < ActiveRecord::Migration[8.1]
  def change
    add_column :letters, :letter_class, :string
  end
end
