class GrammarLessonsController < ApplicationController
  def index
    @lessons_by_level = GrammarLesson::LEVELS.each_with_object({}) do |level, hash|
      lessons = GrammarLesson.by_level(level)
      hash[level] = lessons if lessons.any?
    end
    @completed_ids = current_user.completed_grammar_lessons.pluck(:id).to_set
  end

  def show
    @lesson      = GrammarLesson.includes(:grammar_rules).find(params[:id])
    @completed   = current_user.user_grammar_lessons.exists?(grammar_lesson: @lesson)
    ordered      = GrammarLesson.order(:position).to_a
    idx          = ordered.index(@lesson)
    @prev_lesson = idx > 0 ? ordered[idx - 1] : nil
    @next_lesson = idx < ordered.length - 1 ? ordered[idx + 1] : nil
    @exercises_json = build_exercises(@lesson).to_json
  end

  private

  def build_exercises(lesson)
    rules = lesson.grammar_rules.select { |r| r.tamil_example.present? && r.english_translation.present? }
    return [] if rules.empty?

    distractors_pool = GrammarRule
      .where.not(grammar_lesson_id: lesson.id)
      .where.not(english_translation: [nil, ""])
      .pluck(:english_translation)
      .map { |t| clean_text(t) }
      .uniq
      .reject { |t| t.length < 4 || t.length > 100 }

    rules.map do |rule|
      question = clean_text(rule.tamil_example.split("|").first)
      answer   = clean_text(rule.english_translation.split("|").first)
      next if question.blank? || answer.blank?

      wrong   = distractors_pool.reject { |d| d == answer }.sample(3)
      options = ([answer] + wrong).shuffle
      {
        question:    question,
        options:     options,
        correct:     options.index(answer),
        explanation: rule.explanation.to_s.truncate(120)
      }
    end.compact
  end

  def clean_text(str)
    str.to_s.gsub(/\(.*?\)/, "").gsub(/\s+/, " ").strip.truncate(90)
  end

  public

  def complete
    lesson = GrammarLesson.find(params[:id])
    ugl = current_user.user_grammar_lessons.find_or_initialize_by(grammar_lesson: lesson)
    ugl.completed_at ||= Time.current
    ugl.save!
    render json: { completed: true, total: current_user.completed_grammar_lessons.count }
  end
end
