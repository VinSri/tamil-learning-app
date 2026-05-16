class CreateLetters < ActiveRecord::Migration[8.1]
  def change
    create_table :letters do |t|
      t.string :tamil
      t.string :roman
      t.string :kind
      t.integer :position

      t.timestamps
    end
  end
end
