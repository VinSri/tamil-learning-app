class DashboardController < ApplicationController
  def index
    @progress = current_user.user_progress || UserProgress.create(user: current_user)
    @stats = {
      words_learned:      current_user.words.count,
      letters_learned:    current_user.letters.count,
      lessons_completed:  current_user.completed_grammar_lessons.count,
      total_words:        Word.count,
      total_letters:      Letter.count,
      total_lessons:      GrammarLesson.count,
      streak_days:        @progress.streak_days,
      study_time:         @progress.study_time_minutes
    }
    @achievements             = Achievement.all
    @unlocked_achievement_ids = current_user.achievements.pluck(:id)

    @curriculum_steps    = Curriculum.all_steps
    @curriculum_position = Curriculum.current_position(current_user)
    @current_step        = Curriculum.step(@curriculum_position)
  end
end
