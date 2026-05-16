class AddEnglishToNiganduEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :nigandu_entries, :english, :string
  end
end
