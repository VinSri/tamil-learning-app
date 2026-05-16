class CreateWords < ActiveRecord::Migration[8.1]
  def change
    create_table :words do |t|
      t.string :tamil
      t.string :english
      t.string :pronunciation
      t.string :category

      t.timestamps
    end
  end
end
