module Curriculum
  STEPS = [
    # — Script foundation —
    { id:  1, title: "Tamil Script Overview",         subtitle: "The writing system and its structure",      type: :grammar,  ref: 4  },
    { id:  2, title: "Vowels — உயிர் எழுத்து",         subtitle: "Learn the 12 vowels",                       type: :letters,  filter: "vowel"     },
    { id:  3, title: "Short & Long Vowels",           subtitle: "குறில் and நெடில்",                           type: :grammar,  ref: 5  },
    { id:  4, title: "Consonants — மெய் எழுத்து",      subtitle: "Learn the 18 consonants",                   type: :letters,  filter: "consonant"  },
    { id:  5, title: "Three Classes of Consonants",   subtitle: "வல்லினம், மெல்லினம், இடையினம்",               type: :grammar,  ref: 6  },
    { id:  6, title: "Compound Letters — உயிர்மெய்",   subtitle: "How vowels and consonants combine",         type: :combinations                                 },
    { id:  7, title: "The Aytham — ஃ",               subtitle: "The unique Tamil character",                type: :grammar,  ref: 9  },
    { id:  8, title: "Phonology",                     subtitle: "How Tamil sounds are made",                 type: :grammar,  ref: 8  },
    # — First words —
    { id:  9, title: "Basic Words",                   subtitle: "Your first Tamil vocabulary",               type: :words,    filter: "basics"    },
    { id: 10, title: "Numbers",                       subtitle: "Count in Tamil",                            type: :words,    filter: "numbers"   },
    { id: 11, title: "Family",                        subtitle: "Family relationships",                      type: :words,    filter: "family"    },
    # — Core grammar —
    { id: 12, title: "Pronouns",                      subtitle: "நான், நீ, அவன், அவள்…",                     type: :grammar,  ref: 2  },
    { id: 13, title: "Sentence Structure",            subtitle: "Subject–Object–Verb word order",            type: :grammar,  ref: 1  },
    { id: 14, title: "Noun Classes",                  subtitle: "உயர்திணை and அஃறிணை",                       type: :grammar,  ref: 11 },
    { id: 15, title: "Gender, Number & Person",       subtitle: "Who, how many, which person",               type: :grammar,  ref: 12 },
    { id: 16, title: "Introduction to Cases",         subtitle: "How nouns change meaning",                  type: :grammar,  ref: 10 },
    { id: 17, title: "The Eight Cases",               subtitle: "வேற்றுமை — overview",                       type: :grammar,  ref: 13 },
    { id: 18, title: "Cases 1–4",                     subtitle: "Nominative, Accusative, Instrumental, Dative", type: :grammar, ref: 14 },
    { id: 19, title: "Cases 5–8",                     subtitle: "Ablative, Genitive, Locative, Vocative",    type: :grammar,  ref: 15 },
    # — More vocabulary —
    { id: 20, title: "Colors & Body",                 subtitle: "Describing people and things",              type: :words,    filter: "colors"    },
    { id: 21, title: "Food & Places",                 subtitle: "Everyday words",                            type: :words,    filter: "food"      },
    # — Verbs —
    { id: 22, title: "What is a Tamil Verb?",         subtitle: "வினை — the engine of Tamil",                type: :grammar,  ref: 16 },
    { id: 23, title: "The Three Tenses",              subtitle: "Past, present, future",                     type: :grammar,  ref: 17 },
    { id: 24, title: "Verb Tenses in Practice",       subtitle: "Apply what you know",                       type: :grammar,  ref: 3  },
    { id: 25, title: "The 27 Verb Endings",           subtitle: "வினைமுற்று — finite verb forms",            type: :grammar,  ref: 18 },
    { id: 26, title: "Optative & Negative",           subtitle: "Expressing wishes and negation",            type: :grammar,  ref: 19 },
    # — Reading —
    { id: 27, title: "First Reading",                 subtitle: "Read your first Tamil text",                type: :reading                      },
    # — Classical —
    { id: 28, title: "Introduction to Classical Tamil", subtitle: "Enter the classical world",              type: :grammar,  ref: 20 },
  ].freeze

  def self.all_steps
    STEPS
  end

  def self.step(position)
    STEPS.find { |s| s[:id] == position }
  end

  def self.total
    STEPS.size
  end

  # Returns the URL path for a given step
  def self.path_for(step, url_helpers)
    case step[:type]
    when :grammar       then url_helpers.grammar_lesson_path(step[:ref])
    when :letters       then url_helpers.letters_path(kind: step[:filter])
    when :combinations  then url_helpers.letters_combinations_path
    when :words         then url_helpers.words_path(category: step[:filter])
    when :reading       then url_helpers.reading_passages_path
    when :nigandu       then url_helpers.nigandu_index_path
    end
  end

  # Derives the furthest accessible step from the user's completed grammar lessons
  def self.current_position(user)
    completed_lesson_ids = user.user_grammar_lessons
                               .where.not(completed_at: nil)
                               .pluck(:grammar_lesson_id)

    STEPS.each do |step|
      next if step[:type] != :grammar
      return step[:id] unless completed_lesson_ids.include?(step[:ref])
    end

    STEPS.last[:id]
  end
end
