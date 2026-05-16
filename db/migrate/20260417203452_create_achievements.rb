class CreateAchievements < ActiveRecord::Migration[8.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.string :icon
      t.string :condition_key
      t.integer :threshold

      t.timestamps
    end
  end
end
