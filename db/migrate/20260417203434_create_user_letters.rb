class CreateUserLetters < ActiveRecord::Migration[8.1]
  def change
    create_table :user_letters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :letter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
