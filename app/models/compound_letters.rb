module CompoundLetters
  VOWELS = [
    { tamil: "அ", roman: "a",  matra: nil   },
    { tamil: "ஆ", roman: "ā",  matra: "ா"  },
    { tamil: "இ", roman: "i",  matra: "ி"  },
    { tamil: "ஈ", roman: "ī",  matra: "ீ"  },
    { tamil: "உ", roman: "u",  matra: "ு"  },
    { tamil: "ஊ", roman: "ū",  matra: "ூ"  },
    { tamil: "எ", roman: "e",  matra: "ெ"  },
    { tamil: "ஏ", roman: "ē",  matra: "ே"  },
    { tamil: "ஐ", roman: "ai", matra: "ை"  },
    { tamil: "ஒ", roman: "o",  matra: "ொ"  },
    { tamil: "ஓ", roman: "ō",  matra: "ோ"  },
    { tamil: "ஔ", roman: "au", matra: "ௌ" },
  ].freeze

  CONSONANTS = [
    { tamil: "க", roman: "k",  klass: "vallinam"  },
    { tamil: "ங", roman: "ṅ",  klass: "mellinam"  },
    { tamil: "ச", roman: "c",  klass: "vallinam"  },
    { tamil: "ஞ", roman: "ñ",  klass: "mellinam"  },
    { tamil: "ட", roman: "ṭ",  klass: "vallinam"  },
    { tamil: "ண", roman: "ṇ",  klass: "mellinam"  },
    { tamil: "த", roman: "t",  klass: "vallinam"  },
    { tamil: "ந", roman: "n",  klass: "mellinam"  },
    { tamil: "ப", roman: "p",  klass: "vallinam"  },
    { tamil: "ம", roman: "m",  klass: "mellinam"  },
    { tamil: "ய", roman: "y",  klass: "idaiyinam" },
    { tamil: "ர", roman: "r",  klass: "idaiyinam" },
    { tamil: "ல", roman: "l",  klass: "idaiyinam" },
    { tamil: "வ", roman: "v",  klass: "idaiyinam" },
    { tamil: "ழ", roman: "ẓ",  klass: "idaiyinam" },
    { tamil: "ள", roman: "ḷ",  klass: "idaiyinam" },
    { tamil: "ற", roman: "ṟ",  klass: "vallinam"  },
    { tamil: "ன", roman: "ṉ",  klass: "mellinam"  },
  ].freeze

  CLASS_COLORS = {
    "vallinam"  => "text-red-500",
    "mellinam"  => "text-teal-500",
    "idaiyinam" => "text-violet-500"
  }.freeze

  def self.grid
    CONSONANTS.map do |con|
      row = VOWELS.map do |vow|
        tamil = vow[:matra] ? con[:tamil] + vow[:matra] : con[:tamil]
        { tamil: tamil, roman: con[:roman] + vow[:roman], consonant: con, vowel: vow }
      end
      { consonant: con, cells: row }
    end
  end

  def self.all_cells
    grid.flat_map { |row| row[:cells] }
  end
end
