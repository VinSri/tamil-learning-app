class UserProgress < ApplicationRecord
  belongs_to :user

  def update_streak!
    today = Date.today
    return if last_study_date == today

    if last_study_date == today - 1
      increment!(:streak_days)
    elsif last_study_date.nil?
      update!(streak_days: 1)
    else
      update!(streak_days: 1)
    end

    update!(last_study_date: today)
  end

  def add_study_time!(minutes)
    increment!(:study_time_minutes, minutes)
    update_streak!
  end
end
