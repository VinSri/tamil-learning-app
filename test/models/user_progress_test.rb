require "test_helper"

class UserProgressTest < ActiveSupport::TestCase
  setup do
    @progress = user_progresses(:vino_progress)
  end

  test "update_streak! increments streak on consecutive day" do
    @progress.update!(last_study_date: Date.yesterday)
    @progress.update_streak!
    assert_equal 4, @progress.reload.streak_days
    assert_equal Date.today, @progress.last_study_date
  end

  test "update_streak! resets streak after a gap" do
    @progress.update!(last_study_date: Date.today - 3)
    @progress.update_streak!
    assert_equal 1, @progress.reload.streak_days
  end

  test "update_streak! is idempotent when called twice in one day" do
    @progress.update!(last_study_date: Date.today)
    streak_before = @progress.streak_days
    @progress.update_streak!
    assert_equal streak_before, @progress.reload.streak_days
  end

  test "add_study_time! increments study_time_minutes" do
    before = @progress.study_time_minutes
    @progress.add_study_time!(5)
    assert_equal before + 5, @progress.reload.study_time_minutes
  end

  test "add_study_time! also updates the streak" do
    @progress.update!(last_study_date: Date.yesterday)
    @progress.add_study_time!(10)
    assert_equal Date.today, @progress.reload.last_study_date
  end
end
