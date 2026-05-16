class CreateNiganduEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :nigandu_entries do |t|
      t.integer :sutra_number, null: false
      t.string :headword, null: false
      t.jsonb :synonyms, default: []
      t.string :category
      t.integer :part

      t.timestamps
    end

    add_index :nigandu_entries, :sutra_number, unique: true
    add_index :nigandu_entries, :headword
    add_index :nigandu_entries, :category
  end
end
