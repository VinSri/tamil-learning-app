class Letter < ApplicationRecord
  has_many :user_letters, dependent: :destroy
  has_many :users, through: :user_letters

  KINDS = %w[vowel consonant compound aytham].freeze

  scope :vowels,     -> { where(kind: 'vowel').order(:position) }
  scope :consonants, -> { where(kind: 'consonant').order(:position) }
  scope :compounds,  -> { where(kind: 'compound').order(:position) }
  scope :by_stage,   -> { where.not(stage: nil).order(:stage, :position) }

  CLASSES = %w[vallinam mellinam idaiyinam].freeze

  # Stages: vowels first (traditional order, short/long pairs), then consonant groups, then Aytham.
  # Vowels 1-7 · Consonants 8-15 · Special 16
  STAGE_LABELS = {
     1 => { label: "அ · ஆ",  section: "vowels" },
     2 => { label: "இ · ஈ",  section: "vowels" },
     3 => { label: "உ · ஊ",  section: "vowels" },
     4 => { label: "எ · ஏ",  section: "vowels" },
     5 => { label: "ஐ",       section: "vowels" },
     6 => { label: "ஒ · ஓ",  section: "vowels" },
     7 => { label: "ஔ",       section: "vowels" },
     8 => { label: "ட · ப · ம", section: "consonants" },
     9 => { label: "ர · ச · க", section: "consonants" },
    10 => { label: "த · ந · வ", section: "consonants" },
    11 => { label: "ன",          section: "consonants" },
    12 => { label: "ண",          section: "consonants" },
    13 => { label: "ல · ள · ழ", section: "consonants" },
    14 => { label: "ய · ங",     section: "consonants" },
    15 => { label: "ஞ · ற",     section: "consonants" },
    16 => { label: "ஃ",          section: "special" }
  }.freeze

  SECTIONS = [
    { key: "vowels",      title: "Vowels",      tamil: "உயிர் எழுத்து", color: "text-amber-500"  },
    { key: "consonants",  title: "Consonants",  tamil: "மெய் எழுத்து",  color: "text-red-400"    },
    { key: "special",     title: "Special",     tamil: "ஆய்த எழுத்து", color: "text-gray-400"   }
  ].freeze

  validates :tamil, presence: true, uniqueness: true
  validates :roman, presence: true
  validates :kind, inclusion: { in: KINDS }
end
