class CreateReadingPassages < ActiveRecord::Migration[8.1]
  def change
    create_table :reading_passages do |t|
      t.string :title
      t.text :content
      t.text :translation
      t.string :level

      t.timestamps
    end
  end
end
