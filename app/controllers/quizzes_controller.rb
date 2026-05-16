class QuizzesController < ApplicationController
  def index
    @level     = params[:level].presence || 'beginner'
    @questions = QuizQuestion.by_level(@level).order('RANDOM()').limit(10)
  end

  def submit
    @level     = params[:level]
    @questions = QuizQuestion.where(id: params[:answers].keys)
    @answers   = params[:answers] # { question_id => selected_index }

    @results = @questions.map do |q|
      selected = @answers[q.id.to_s].to_i
      { question: q, selected: selected, correct: selected == q.correct_index }
    end

    @score = @results.count { |r| r[:correct] }
    @total = @results.count

    current_user.user_progress.add_study_time!(5)
    check_achievements!

    render :results
  end

  private

  def check_achievements!
    progress = current_user.user_progress
    achievements = Achievement.all

    achievements.each do |achievement|
      next if current_user.achievements.include?(achievement)

      value = case achievement.condition_key
              when 'words_learned'    then current_user.words.count
              when 'letters_learned'  then current_user.letters.count
              when 'streak_days'      then progress.streak_days
              when 'study_time_minutes' then progress.study_time_minutes
              else 0
              end

      if value >= achievement.threshold
        current_user.user_achievements.create(achievement: achievement, unlocked_at: Time.current)
      end
    end
  end
end
