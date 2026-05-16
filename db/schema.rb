# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_09_132504) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "condition_key"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon"
    t.string "name"
    t.integer "threshold"
    t.datetime "updated_at", null: false
  end

  create_table "grammar_lessons", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "level"
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "grammar_rules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "english_translation"
    t.text "explanation"
    t.bigint "grammar_lesson_id", null: false
    t.text "rule_text"
    t.string "tamil_example"
    t.datetime "updated_at", null: false
    t.index ["grammar_lesson_id"], name: "index_grammar_rules_on_grammar_lesson_id"
  end

  create_table "letters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "kind"
    t.string "letter_class"
    t.integer "position"
    t.string "roman"
    t.integer "stage"
    t.string "tamil"
    t.datetime "updated_at", null: false
  end

  create_table "nigandu_entries", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "english"
    t.string "headword", null: false
    t.integer "part"
    t.integer "sutra_number", null: false
    t.jsonb "synonyms", default: []
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_nigandu_entries_on_category"
    t.index ["headword"], name: "index_nigandu_entries_on_headword"
    t.index ["sutra_number"], name: "index_nigandu_entries_on_sutra_number", unique: true
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.string "category"
    t.integer "correct_index"
    t.datetime "created_at", null: false
    t.string "level"
    t.jsonb "options"
    t.text "question"
    t.datetime "updated_at", null: false
  end

  create_table "reading_passages", force: :cascade do |t|
    t.jsonb "annotations", default: {}
    t.text "content"
    t.datetime "created_at", null: false
    t.string "level"
    t.string "title"
    t.text "translation"
    t.datetime "updated_at", null: false
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "unlocked_at"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_grammar_lessons", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "grammar_lesson_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["grammar_lesson_id"], name: "index_user_grammar_lessons_on_grammar_lesson_id"
    t.index ["user_id", "grammar_lesson_id"], name: "index_user_grammar_lessons_on_user_id_and_grammar_lesson_id", unique: true
    t.index ["user_id"], name: "index_user_grammar_lessons_on_user_id"
  end

  create_table "user_letters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "letter_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["letter_id"], name: "index_user_letters_on_letter_id"
    t.index ["user_id"], name: "index_user_letters_on_user_id"
  end

  create_table "user_progresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "last_study_date"
    t.integer "streak_days"
    t.integer "study_time_minutes"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_progresses_on_user_id"
  end

  create_table "user_words", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "word_id", null: false
    t.index ["user_id"], name: "index_user_words_on_user_id"
    t.index ["word_id"], name: "index_user_words_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "curriculum_position", default: 1, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "level"
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "learner", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "emoji"
    t.string "english"
    t.string "pronunciation"
    t.string "tamil"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "grammar_rules", "grammar_lessons"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_grammar_lessons", "grammar_lessons"
  add_foreign_key "user_grammar_lessons", "users"
  add_foreign_key "user_letters", "letters"
  add_foreign_key "user_letters", "users"
  add_foreign_key "user_progresses", "users"
  add_foreign_key "user_words", "users"
  add_foreign_key "user_words", "words"
end
