class AddStageToLetters < ActiveRecord::Migration[8.1]
  def change
    add_column :letters, :stage, :integer
  end
end
