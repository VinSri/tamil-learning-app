class AddCurriculumPositionToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :curriculum_position, :integer, default: 1, null: false
  end
end
