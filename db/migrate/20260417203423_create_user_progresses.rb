class CreateUserProgresses < ActiveRecord::Migration[8.1]
  def change
    create_table :user_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :streak_days
      t.integer :study_time_minutes
      t.date :last_study_date

      t.timestamps
    end
  end
end
