class AddEmojiToWords < ActiveRecord::Migration[8.1]
  def change
    add_column :words, :emoji, :string
  end
end
