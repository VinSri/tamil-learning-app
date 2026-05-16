puts "Seeding database..."

# ============================================================
# LETTERS
# ============================================================
puts "Seeding letters..."

# Stages: vowels first (traditional short/long pairs), then consonant groups, then Aytham.
# Vowels stages 1-7 · Consonants stages 8-15 · Aytham stage 16
vowels = [
  { tamil: 'அ', roman: 'a',  position: 1, stage: 1 },
  { tamil: 'ஆ', roman: 'ā',  position: 2, stage: 1 },
  { tamil: 'இ', roman: 'i',  position: 1, stage: 2 },
  { tamil: 'ஈ', roman: 'ī',  position: 2, stage: 2 },
  { tamil: 'உ', roman: 'u',  position: 1, stage: 3 },
  { tamil: 'ஊ', roman: 'ū',  position: 2, stage: 3 },
  { tamil: 'எ', roman: 'e',  position: 1, stage: 4 },
  { tamil: 'ஏ', roman: 'ē',  position: 2, stage: 4 },
  { tamil: 'ஐ', roman: 'ai', position: 1, stage: 5 },
  { tamil: 'ஒ', roman: 'o',  position: 1, stage: 6 },
  { tamil: 'ஓ', roman: 'ō',  position: 2, stage: 6 },
  { tamil: 'ஔ', roman: 'au', position: 1, stage: 7 }
]

consonants = [
  # Stage 8 — ட, ப, ம (Singapore group 1: most visually distinct vallinam)
  { tamil: 'ட்', roman: 'ṭ', position: 1, stage: 8,  letter_class: 'vallinam'  },
  { tamil: 'ப்', roman: 'p', position: 2, stage: 8,  letter_class: 'vallinam'  },
  { tamil: 'ம்', roman: 'm', position: 3, stage: 8,  letter_class: 'mellinam'  },
  # Stage 9 — ர, ச, க
  { tamil: 'ர்', roman: 'r', position: 1, stage: 9,  letter_class: 'idaiyinam' },
  { tamil: 'ச்', roman: 'c', position: 2, stage: 9,  letter_class: 'vallinam'  },
  { tamil: 'க்', roman: 'k', position: 3, stage: 9,  letter_class: 'vallinam'  },
  # Stage 10 — த, ந, வ
  { tamil: 'த்', roman: 't', position: 1, stage: 10, letter_class: 'vallinam'  },
  { tamil: 'ந்', roman: 'n', position: 2, stage: 10, letter_class: 'mellinam'  },
  { tamil: 'வ்', roman: 'v', position: 3, stage: 10, letter_class: 'idaiyinam' },
  # Stage 11 — ன
  { tamil: 'ன்', roman: 'ṉ', position: 1, stage: 11, letter_class: 'mellinam'  },
  # Stage 12 — ண
  { tamil: 'ண்', roman: 'ṇ', position: 1, stage: 12, letter_class: 'mellinam'  },
  # Stage 13 — ல, ள, ழ
  { tamil: 'ல்', roman: 'l', position: 1, stage: 13, letter_class: 'idaiyinam' },
  { tamil: 'ள்', roman: 'ḷ', position: 2, stage: 13, letter_class: 'idaiyinam' },
  { tamil: 'ழ்', roman: 'ḻ', position: 3, stage: 13, letter_class: 'idaiyinam' },
  # Stage 14 — ய, ங
  { tamil: 'ய்', roman: 'y', position: 1, stage: 14, letter_class: 'idaiyinam' },
  { tamil: 'ங்', roman: 'ṅ', position: 2, stage: 14, letter_class: 'mellinam'  },
  # Stage 15 — ஞ, ற
  { tamil: 'ஞ்', roman: 'ñ', position: 1, stage: 15, letter_class: 'mellinam'  },
  { tamil: 'ற்', roman: 'ṟ', position: 2, stage: 15, letter_class: 'vallinam'  }
]

aytham = { tamil: 'ஃ', roman: 'ḵ', position: 1, stage: 16, kind: 'aytham' }

vowels.each do |attrs|
  letter = Letter.find_or_initialize_by(tamil: attrs[:tamil])
  letter.assign_attributes(attrs.merge(kind: 'vowel'))
  letter.save!
end

consonants.each do |attrs|
  letter = Letter.find_or_initialize_by(tamil: attrs[:tamil])
  letter.assign_attributes(attrs.merge(kind: 'consonant'))
  letter.save!
end

a = Letter.find_or_initialize_by(tamil: aytham[:tamil])
a.assign_attributes(aytham)
a.save!

puts "  #{Letter.count} letters seeded"

# ============================================================
# VOCABULARY
# ============================================================
puts "Seeding vocabulary..."

words = [
  # Basics
  { tamil: 'வணக்கம்', english: 'Hello', pronunciation: 'vanakkam', category: 'basics', emoji: '🙏' },
  { tamil: 'நன்றி', english: 'Thank you', pronunciation: 'nandri', category: 'basics', emoji: '😊' },
  { tamil: 'ஆம்', english: 'Yes', pronunciation: 'aam', category: 'basics', emoji: '✅' },
  { tamil: 'இல்லை', english: 'No', pronunciation: 'illai', category: 'basics', emoji: '❌' },
  { tamil: 'தயவுசெய்து', english: 'Please', pronunciation: 'dayavuseythu', category: 'basics', emoji: '🤲' },
  { tamil: 'மன்னிக்கவும்', english: 'Sorry', pronunciation: 'mannikkavum', category: 'basics', emoji: '🙇' },
  { tamil: 'விடை', english: 'Goodbye', pronunciation: 'vidai', category: 'basics', emoji: '👋' },
  { tamil: 'நல்ல காலை', english: 'Good morning', pronunciation: 'nalla kaalai', category: 'basics', emoji: '🌅' },
  { tamil: 'நல்ல மாலை', english: 'Good evening', pronunciation: 'nalla maalai', category: 'basics', emoji: '🌇' },
  { tamil: 'இனிய இரவு', english: 'Good night', pronunciation: 'iniya iravu', category: 'basics', emoji: '🌙' },
  # Numbers
  { tamil: 'ஒன்று', english: 'One', pronunciation: 'ondru', category: 'numbers', emoji: '1️⃣' },
  { tamil: 'இரண்டு', english: 'Two', pronunciation: 'irandu', category: 'numbers', emoji: '2️⃣' },
  { tamil: 'மூன்று', english: 'Three', pronunciation: 'moondru', category: 'numbers', emoji: '3️⃣' },
  { tamil: 'நான்கு', english: 'Four', pronunciation: 'naangu', category: 'numbers', emoji: '4️⃣' },
  { tamil: 'ஐந்து', english: 'Five', pronunciation: 'ainthu', category: 'numbers', emoji: '5️⃣' },
  { tamil: 'ஆறு', english: 'Six', pronunciation: 'aaru', category: 'numbers', emoji: '6️⃣' },
  { tamil: 'ஏழு', english: 'Seven', pronunciation: 'ezhu', category: 'numbers', emoji: '7️⃣' },
  { tamil: 'எட்டு', english: 'Eight', pronunciation: 'ettu', category: 'numbers', emoji: '8️⃣' },
  { tamil: 'ஒன்பது', english: 'Nine', pronunciation: 'onbathu', category: 'numbers', emoji: '9️⃣' },
  { tamil: 'பத்து', english: 'Ten', pronunciation: 'paththu', category: 'numbers', emoji: '🔟' },
  { tamil: 'இருபது', english: 'Twenty', pronunciation: 'irupathu', category: 'numbers', emoji: '✌️' },
  { tamil: 'நூறு', english: 'Hundred', pronunciation: 'nooru', category: 'numbers', emoji: '💯' },
  { tamil: 'ஆயிரம்', english: 'Thousand', pronunciation: 'aayiram', category: 'numbers', emoji: '🔢' },
  # Colors
  { tamil: 'சிவப்பு', english: 'Red', pronunciation: 'sivappu', category: 'colors', emoji: '🔴' },
  { tamil: 'நீலம்', english: 'Blue', pronunciation: 'neelam', category: 'colors', emoji: '🔵' },
  { tamil: 'பச்சை', english: 'Green', pronunciation: 'pacchai', category: 'colors', emoji: '🟢' },
  { tamil: 'மஞ்சள்', english: 'Yellow', pronunciation: 'manjal', category: 'colors', emoji: '🟡' },
  { tamil: 'கருப்பு', english: 'Black', pronunciation: 'karuppu', category: 'colors', emoji: '⚫' },
  { tamil: 'வெள்ளை', english: 'White', pronunciation: 'vellai', category: 'colors', emoji: '⚪' },
  { tamil: 'ஆரஞ்சு', english: 'Orange', pronunciation: 'aaranju', category: 'colors', emoji: '🟠' },
  { tamil: 'இளஞ்சிவப்பு', english: 'Pink', pronunciation: 'ilanjivappu', category: 'colors', emoji: '🩷' },
  { tamil: 'ஊதா', english: 'Purple', pronunciation: 'utha', category: 'colors', emoji: '🟣' },
  { tamil: 'பழுப்பு', english: 'Brown', pronunciation: 'pazhuppu', category: 'colors', emoji: '🟤' },
  # Family
  { tamil: 'அம்மா', english: 'Mother', pronunciation: 'amma', category: 'family', emoji: '👩' },
  { tamil: 'அப்பா', english: 'Father', pronunciation: 'appa', category: 'family', emoji: '👨' },
  { tamil: 'அண்ணன்', english: 'Elder brother', pronunciation: 'annan', category: 'family', emoji: '👦' },
  { tamil: 'அக்கா', english: 'Elder sister', pronunciation: 'akka', category: 'family', emoji: '👧' },
  { tamil: 'தம்பி', english: 'Younger brother', pronunciation: 'thambi', category: 'family', emoji: '🧒' },
  { tamil: 'தங்கை', english: 'Younger sister', pronunciation: 'thangai', category: 'family', emoji: '👧' },
  { tamil: 'தாத்தா', english: 'Grandfather', pronunciation: 'thaththa', category: 'family', emoji: '👴' },
  { tamil: 'பாட்டி', english: 'Grandmother', pronunciation: 'paatti', category: 'family', emoji: '👵' },
  { tamil: 'மகன்', english: 'Son', pronunciation: 'magan', category: 'family', emoji: '👦' },
  { tamil: 'மகள்', english: 'Daughter', pronunciation: 'magal', category: 'family', emoji: '👧' },
  { tamil: 'மனைவி', english: 'Wife', pronunciation: 'manaivi', category: 'family', emoji: '💍' },
  { tamil: 'கணவன்', english: 'Husband', pronunciation: 'kanavan', category: 'family', emoji: '💍' },
  # Food
  { tamil: 'சாப்பாடு', english: 'Food', pronunciation: 'saappaadu', category: 'food', emoji: '🍽️' },
  { tamil: 'தண்ணீர்', english: 'Water', pronunciation: 'thanneer', category: 'food', emoji: '💧' },
  { tamil: 'சோறு', english: 'Rice', pronunciation: 'sooru', category: 'food', emoji: '🍚' },
  { tamil: 'இட்லி', english: 'Idli', pronunciation: 'idli', category: 'food', emoji: '🫓' },
  { tamil: 'தோசை', english: 'Dosa', pronunciation: 'thosai', category: 'food', emoji: '🥞' },
  { tamil: 'சாம்பார்', english: 'Sambar', pronunciation: 'saambaar', category: 'food', emoji: '🍲' },
  { tamil: 'சட்னி', english: 'Chutney', pronunciation: 'chatni', category: 'food', emoji: '🥣' },
  { tamil: 'வடை', english: 'Vada', pronunciation: 'vadai', category: 'food', emoji: '🍩' },
  { tamil: 'பொங்கல்', english: 'Pongal', pronunciation: 'pongal', category: 'food', emoji: '🍛' },
  { tamil: 'பால்', english: 'Milk', pronunciation: 'paal', category: 'food', emoji: '🥛' },
  { tamil: 'காபி', english: 'Coffee', pronunciation: 'kaapi', category: 'food', emoji: '☕' },
  { tamil: 'தேநீர்', english: 'Tea', pronunciation: 'theneer', category: 'food', emoji: '🍵' },
  { tamil: 'பழம்', english: 'Fruit', pronunciation: 'pazham', category: 'food', emoji: '🍎' },
  { tamil: 'காய்கறி', english: 'Vegetable', pronunciation: 'kaaikari', category: 'food', emoji: '🥦' },
  # Places
  { tamil: 'வீடு', english: 'Home', pronunciation: 'veedu', category: 'places', emoji: '🏠' },
  { tamil: 'பள்ளி', english: 'School', pronunciation: 'palli', category: 'places', emoji: '🏫' },
  { tamil: 'கோயில்', english: 'Temple', pronunciation: 'koyil', category: 'places', emoji: '🛕' },
  { tamil: 'கடை', english: 'Shop', pronunciation: 'kadai', category: 'places', emoji: '🏪' },
  { tamil: 'சந்தை', english: 'Market', pronunciation: 'santhai', category: 'places', emoji: '🛒' },
  { tamil: 'மருத்துவமனை', english: 'Hospital', pronunciation: 'maruththuvamanai', category: 'places', emoji: '🏥' },
  { tamil: 'அலுவலகம்', english: 'Office', pronunciation: 'aluvalakam', category: 'places', emoji: '🏢' },
  { tamil: 'நூலகம்', english: 'Library', pronunciation: 'noolagam', category: 'places', emoji: '📚' },
  { tamil: 'உணவகம்', english: 'Restaurant', pronunciation: 'unavagam', category: 'places', emoji: '🍴' },
  { tamil: 'பூங்கா', english: 'Park', pronunciation: 'poonka', category: 'places', emoji: '🌳' },
  # Body
  { tamil: 'தலை', english: 'Head', pronunciation: 'thalai', category: 'body', emoji: '🗣️' },
  { tamil: 'கண்', english: 'Eye', pronunciation: 'kan', category: 'body', emoji: '👁️' },
  { tamil: 'காது', english: 'Ear', pronunciation: 'kaadhu', category: 'body', emoji: '👂' },
  { tamil: 'மூக்கு', english: 'Nose', pronunciation: 'mookku', category: 'body', emoji: '👃' },
  { tamil: 'வாய்', english: 'Mouth', pronunciation: 'vaay', category: 'body', emoji: '👄' },
  { tamil: 'கை', english: 'Hand', pronunciation: 'kai', category: 'body', emoji: '✋' },
  { tamil: 'கால்', english: 'Leg', pronunciation: 'kaal', category: 'body', emoji: '🦵' },
  { tamil: 'விரல்', english: 'Finger', pronunciation: 'viral', category: 'body', emoji: '👆' },
  # Nature
  { tamil: 'சூரியன்', english: 'Sun', pronunciation: 'sooryan', category: 'nature', emoji: '☀️' },
  { tamil: 'சந்திரன்', english: 'Moon', pronunciation: 'santhiran', category: 'nature', emoji: '🌙' },
  { tamil: 'நட்சத்திரம்', english: 'Star', pronunciation: 'natchaththiram', category: 'nature', emoji: '⭐' },
  { tamil: 'வானம்', english: 'Sky', pronunciation: 'vaanam', category: 'nature', emoji: '🌤️' },
  { tamil: 'மேகம்', english: 'Cloud', pronunciation: 'megam', category: 'nature', emoji: '☁️' },
  { tamil: 'மழை', english: 'Rain', pronunciation: 'mazhai', category: 'nature', emoji: '🌧️' },
  { tamil: 'மரம்', english: 'Tree', pronunciation: 'maram', category: 'nature', emoji: '🌳' },
  { tamil: 'பூ', english: 'Flower', pronunciation: 'poo', category: 'nature', emoji: '🌸' },
  { tamil: 'நதி', english: 'River', pronunciation: 'nathi', category: 'nature', emoji: '🏞️' },
  { tamil: 'கடல்', english: 'Sea', pronunciation: 'kadal', category: 'nature', emoji: '🌊' },
  # Animals
  { tamil: 'நாய்', english: 'Dog', pronunciation: 'naay', category: 'animals', emoji: '🐕' },
  { tamil: 'பூனை', english: 'Cat', pronunciation: 'poonai', category: 'animals', emoji: '🐈' },
  { tamil: 'பசு', english: 'Cow', pronunciation: 'pasu', category: 'animals', emoji: '🐄' },
  { tamil: 'யானை', english: 'Elephant', pronunciation: 'yaanai', category: 'animals', emoji: '🐘' },
  { tamil: 'குதிரை', english: 'Horse', pronunciation: 'kuthirai', category: 'animals', emoji: '🐎' },
  { tamil: 'பறவை', english: 'Bird', pronunciation: 'paravai', category: 'animals', emoji: '🐦' },
  { tamil: 'மீன்', english: 'Fish', pronunciation: 'meen', category: 'animals', emoji: '🐟' },
  { tamil: 'ஆடு', english: 'Goat', pronunciation: 'aadu', category: 'animals', emoji: '🐐' },
  # Time
  { tamil: 'நேரம்', english: 'Time', pronunciation: 'neram', category: 'time', emoji: '⏰' },
  { tamil: 'நாள்', english: 'Day', pronunciation: 'naal', category: 'time', emoji: '📅' },
  { tamil: 'வாரம்', english: 'Week', pronunciation: 'vaaram', category: 'time', emoji: '🗓️' },
  { tamil: 'மாதம்', english: 'Month', pronunciation: 'maatham', category: 'time', emoji: '📆' },
  { tamil: 'வருடம்', english: 'Year', pronunciation: 'varudam', category: 'time', emoji: '🎊' },
  { tamil: 'இன்று', english: 'Today', pronunciation: 'indru', category: 'time', emoji: '📍' },
  { tamil: 'நேற்று', english: 'Yesterday', pronunciation: 'netru', category: 'time', emoji: '⏪' },
  { tamil: 'நாளை', english: 'Tomorrow', pronunciation: 'naalai', category: 'time', emoji: '⏩' },
  { tamil: 'காலை', english: 'Morning', pronunciation: 'kaalai', category: 'time', emoji: '🌅' },
  { tamil: 'மாலை', english: 'Evening', pronunciation: 'maalai', category: 'time', emoji: '🌆' },
  { tamil: 'இரவு', english: 'Night', pronunciation: 'iravu', category: 'time', emoji: '🌃' },
  # Verbs
  { tamil: 'போ', english: 'Go', pronunciation: 'po', category: 'verbs', emoji: '🚶' },
  { tamil: 'வா', english: 'Come', pronunciation: 'vaa', category: 'verbs', emoji: '🤗' },
  { tamil: 'சாப்பிடு', english: 'Eat', pronunciation: 'saappidu', category: 'verbs', emoji: '🍽️' },
  { tamil: 'குடி', english: 'Drink', pronunciation: 'kudi', category: 'verbs', emoji: '🥤' },
  { tamil: 'படி', english: 'Read/Study', pronunciation: 'padi', category: 'verbs', emoji: '📖' },
  { tamil: 'எழுது', english: 'Write', pronunciation: 'ezhuthu', category: 'verbs', emoji: '✍️' },
  { tamil: 'பார்', english: 'See/Look', pronunciation: 'paar', category: 'verbs', emoji: '👀' },
  { tamil: 'கேள்', english: 'Listen/Ask', pronunciation: 'kel', category: 'verbs', emoji: '👂' },
  { tamil: 'பேசு', english: 'Speak', pronunciation: 'pesu', category: 'verbs', emoji: '🗣️' },
  { tamil: 'தூங்கு', english: 'Sleep', pronunciation: 'thoongu', category: 'verbs', emoji: '😴' },
  # Letters without examples — sourced from Pingala Nigandu
  # ஈ
  { tamil: 'ஈகை', english: 'Generosity', pronunciation: 'eekai', category: 'classical', emoji: '🤝' },
  { tamil: 'ஈரம்', english: 'Compassion', pronunciation: 'eeram', category: 'classical', emoji: '💚' },
  # ஓ
  { tamil: 'ஓசை', english: 'Sound', pronunciation: 'osai', category: 'nature', emoji: '🔔' },
  { tamil: 'ஓங்கல்', english: 'Peak / Hill', pronunciation: 'oongal', category: 'nature', emoji: '⛰️' },
  # ஔ
  { tamil: 'ஔடதம்', english: 'Medicine / Herb', pronunciation: 'oudatham', category: 'classical', emoji: '🌿' },
  # ஞ
  { tamil: 'ஞாயிறு', english: 'Sun (classical)', pronunciation: 'naayiru', category: 'classical', emoji: '☀️' },
  { tamil: 'ஞானம்', english: 'Wisdom', pronunciation: 'gnanam', category: 'classical', emoji: '🧠' }
]

words.each do |w|
  Word.find_or_create_by!(tamil: w[:tamil]) { |r| r.assign_attributes(w) }
      .then { |r| r.update!(emoji: w[:emoji]) if r.emoji != w[:emoji] }
end
puts "  #{Word.count} words seeded"

# ============================================================
# GRAMMAR LESSONS
# ============================================================
puts "Seeding grammar lessons..."

# Lesson 1: Sentence Structure
lesson1 = GrammarLesson.find_or_create_by!(title: 'Sentence Structure') do |l|
  l.level = 'beginner'
  l.position = 1
  l.content = 'Tamil follows Subject-Object-Verb (SOV) order, unlike English which uses Subject-Verb-Object (SVO). The verb always comes at the end of the sentence.'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson1, tamil_example: 'நான் சாப்பாடு சாப்பிடுகிறேன்') do |r|
  r.rule_text = 'Tamil sentence order is Subject → Object → Verb'
  r.explanation = 'In Tamil, the verb always comes last. Place the subject first, then the object, then the verb.'
  r.english_translation = 'I food eat (I eat food)'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson1, tamil_example: 'அவள் பள்ளிக்கு போகிறாள்') do |r|
  r.rule_text = 'Destination markers come before the verb'
  r.explanation = 'The suffix -க்கு means "to". It attaches to the destination noun before the verb.'
  r.english_translation = 'She school-to goes (She goes to school)'
end

# Lesson 2: Pronouns
lesson2 = GrammarLesson.find_or_create_by!(title: 'Pronouns') do |l|
  l.level = 'beginner'
  l.position = 2
  l.content = 'Tamil has distinct pronouns for different levels of formality and respect. The third person distinguishes between masculine, feminine, neuter, and respectful forms.'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson2, tamil_example: 'நான் வருகிறேன்') do |r|
  r.rule_text = 'நான் = I (first person singular)'
  r.explanation = 'நான் is the first person singular pronoun. Used when referring to yourself.'
  r.english_translation = 'I am coming'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson2, tamil_example: 'நீங்கள் எங்கே போகிறீர்கள்?') do |r|
  r.rule_text = 'நீங்கள் = You (formal/plural), நீ = You (informal)'
  r.explanation = 'Use நீங்கள் with elders, strangers, and in formal situations. Use நீ with friends and younger people.'
  r.english_translation = 'Where are you going?'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson2, tamil_example: 'அவர் ஆசிரியர்') do |r|
  r.rule_text = 'அவர் = He/She (respectful), அவன் = He, அவள் = She'
  r.explanation = 'Use அவர் as a gender-neutral respectful third person. அவன் is masculine informal, அவள் is feminine.'
  r.english_translation = 'He/She is a teacher'
end

# Lesson 3: Verb Tenses
lesson3 = GrammarLesson.find_or_create_by!(title: 'Verb Tenses') do |l|
  l.level = 'beginner'
  l.position = 3
  l.content = 'Tamil verbs conjugate for three tenses: past, present, and future. The tense marker is inserted between the verb stem and the personal ending.'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson3, tamil_example: 'நான் சாப்பிட்டேன்') do |r|
  r.rule_text = 'Past tense: verb stem + past marker + personal ending'
  r.explanation = 'Common past markers: -த்த-, -ட்ட-, -ண்ட-. For "I ate": சாப்பிடு (eat) → சாப்பிட்ட + ேன் = சாப்பிட்டேன்'
  r.english_translation = 'I ate'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson3, tamil_example: 'நான் சாப்பிடுகிறேன்') do |r|
  r.rule_text = 'Present tense: verb stem + கிற + personal ending'
  r.explanation = 'The present tense marker is -கிற-. For "I eat": சாப்பிடு + கிற + ேன் = சாப்பிடுகிறேன்'
  r.english_translation = 'I am eating / I eat'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson3, tamil_example: 'நான் சாப்பிடுவேன்') do |r|
  r.rule_text = 'Future tense: verb stem + வ + personal ending'
  r.explanation = 'The future tense marker is -வ-. For "I will eat": சாப்பிடு + வ + ேன் = சாப்பிடுவேன்'
  r.english_translation = 'I will eat'
end

# Lesson 4: Nouns and Cases
lesson4 = GrammarLesson.find_or_create_by!(title: 'Noun Cases') do |l|
  l.level = 'intermediate'
  l.position = 4
  l.content = 'Tamil uses case suffixes (வேற்றுமை உருபுகள்) attached to nouns to show their role in a sentence. There are 8 cases in Tamil.'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson4, tamil_example: 'வீட்டிற்கு போ') do |r|
  r.rule_text = 'Dative case (-க்கு / -இற்கு): indicates direction or recipient'
  r.explanation = 'Attach -க்கு to a noun to mean "to" or "for". வீடு (house) → வீட்டிற்கு (to the house)'
  r.english_translation = 'Go to the house'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson4, tamil_example: 'பள்ளியில் படிக்கிறேன்') do |r|
  r.rule_text = 'Locative case (-இல்): indicates location'
  r.explanation = 'Attach -இல் to a noun to mean "in" or "at". பள்ளி (school) → பள்ளியில் (in school)'
  r.english_translation = 'I study in school'
end

# Lesson 5: Classical Tamil Introduction
lesson5 = GrammarLesson.find_or_create_by!(title: 'Introduction to Classical Tamil') do |l|
  l.level = 'classical'
  l.position = 1
  l.content = 'Classical Tamil (செந்தமிழ்) is the literary form of Tamil used in ancient Sangam literature, Tolkāppiyam, and Thirukkural. It differs from modern spoken Tamil in vocabulary, grammar, and style.'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson5, tamil_example: 'யாதும் ஊரே யாவரும் கேளிர்') do |r|
  r.rule_text = 'Classical Tamil uses archaic verb forms and poetic compression'
  r.explanation = 'This famous Sangam verse means "Every place is my hometown, every person is my kin." Classical Tamil packs deep meaning into very few words using archaic grammatical forms.'
  r.english_translation = 'Every place is home, everyone is family'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson5, tamil_example: 'அகர முதல எழுத்தெல்லாம்') do |r|
  r.rule_text = 'Thirukkural opens with the primacy of the letter அ'
  r.explanation = 'The first Kural: "All letters have the letter அ as their beginning, just as the world has God as its beginning." This illustrates classical Tamil\'s philosophical depth.'
  r.english_translation = 'All letters begin with அ, as all existence begins with God'
end

# ============================================================
# NANNUL-BASED GRAMMAR LESSONS (Sutras cited from Nannūl with G.U. Pope commentary)
# ============================================================

# Lesson 6: The Tamil Script — An Overview
lesson6 = GrammarLesson.find_or_create_by!(title: 'The Tamil Script — An Overview') do |l|
  l.level = 'beginner'
  l.position = 6
  l.content = "Tamil has 30 primary letters (முதல் எழுத்துகள்): 12 vowels (உயிர்) and 18 consonants (மெய்). Vowels are called the 'soul' of letters and consonants the 'body'. Together they combine to form 216 compound letters (உயிர்மெய்), giving Tamil a total of 247 letters. There is also one special letter — the Aytham (ஃ). (Nannūl sutras 57–59, 63)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson6, tamil_example: 'உயிரும் உடம்பும் ஆம் முப்பது முதலே') do |r|
  r.rule_text = '12 vowels + 18 consonants = 30 primary letters'
  r.explanation = 'The Tamil alphabet has 12 vowels (உயிர் — "soul") and 18 consonants (மெய் — "body"). These 30 are the primary letters from which all other letters are formed. (Nannūl sutra 59)'
  r.english_translation = 'Vowels and consonants together make 30 primary letters'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson6, tamil_example: 'அம் முதல் ஈர் ஆ, றாவி; கம் முதல் மெய்ம் மூற வாறென விளம்பினர் புலவர்') do |r|
  r.rule_text = 'Vowels begin with அ (12 total); Consonants begin with க (18 total)'
  r.explanation = 'From அ to ஔ are the 12 vowels. From க to ன are the 18 consonants. This ordering is the foundation of the Tamil alphabet. (Nannūl sutra 63)'
  r.english_translation = 'Vowels: அ to ஔ (12). Consonants: க to ன (18)'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson6, tamil_example: 'உயிர்மெய் இரட்டுநூற்று எட்டுயிர் ஆய்தம்') do |r|
  r.rule_text = '216 compound letters + 1 Aytham = 217 secondary letters'
  r.explanation = 'Each of the 18 consonants combines with each of the 12 vowels to create 216 compound letters (உயிர்மெய்). Add the Aytham (ஃ) and other secondary forms — the total secondary letters number 369. (Nannūl sutra 61)'
  r.english_translation = '18 consonants × 12 vowels = 216 compound letters'
end

# Lesson 7: Short and Long Vowels
lesson7 = GrammarLesson.find_or_create_by!(title: 'Short and Long Vowels — குறில் and நெடில்') do |l|
  l.level = 'beginner'
  l.position = 7
  l.content = "Tamil vowels are divided into two groups by length: 5 short vowels (குறில் — one beat) and 7 long vowels (நெடில் — two beats). Vowel length changes meaning: 'வில்' (bow) vs 'வீல்' (fall). This distinction is fundamental to reading and writing Tamil correctly. (Nannūl sutras 64–65)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson7, tamil_example: 'அ, இ, உ, எ, ஒ — குறில் (short)') do |r|
  r.rule_text = '5 short vowels (குறில்): அ இ உ எ ஒ'
  r.explanation = 'These five vowels are pronounced in one beat (one unit of time). They are called குறில் meaning "short". (Nannūl sutra 64)'
  r.english_translation = 'அ (a), இ (i), உ (u), எ (e), ஒ (o) — each one beat'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson7, tamil_example: 'ஆ, ஈ, ஊ, ஏ, ஐ, ஓ, ஔ — நெடில் (long)') do |r|
  r.rule_text = '7 long vowels (நெடில்): ஆ ஈ ஊ ஏ ஐ ஓ ஔ'
  r.explanation = 'These seven vowels are pronounced in two beats (two units of time). They are called நெடில் meaning "long". (Nannūl sutra 65)'
  r.english_translation = 'ஆ (ā), ஈ (ī), ஊ (ū), ஏ (ē), ஐ (ai), ஓ (ō), ஔ (au) — each two beats'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson7, tamil_example: 'வில் (bow) vs வீல் (to fall)') do |r|
  r.rule_text = 'Vowel length changes word meaning'
  r.explanation = 'In Tamil, the same consonant-vowel combination with different vowel length gives different words. This is why reading the correct vowel length matters critically: வில் (bow/arrow) vs வீல் (to fall); கடல் (sea) vs காடல் (love)'
  r.english_translation = 'Short vs long vowels are different words, not just different pronunciations'
end

# Lesson 8: The Three Classes of Consonants
lesson8 = GrammarLesson.find_or_create_by!(title: 'The Three Classes of Consonants') do |l|
  l.level = 'beginner'
  l.position = 8
  l.content = "Tamil's 18 consonants are divided into three groups of 6, based on how they are pronounced: hard (வல்லினம்), soft/nasal (மெல்லினம்), and middle (இடையினம்). Understanding these groups helps with pronunciation and also with sandhi rules — how letters change when words join together. (Nannūl sutras 68–70)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson8, tamil_example: 'வல்லினம் க, ச, ட, த, ப, ற') do |r|
  r.rule_text = 'வல்லினம் (hard consonants): க ச ட த ப ற'
  r.explanation = 'These six are called "hard" or "strong" consonants (தேனுகள் / surds). They are pronounced with a strong, sharp stop. In English grammar terms, these are the voiceless stops and fricatives. (Nannūl sutra 68)'
  r.english_translation = 'க (k/g), ச (s/ch), ட (t/d), த (th/d), ப (p/b), ற (tr/r) — hard stops'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson8, tamil_example: 'மெல்லினம் ங, ஞ, ண, ந, ம, ன') do |r|
  r.rule_text = 'மெல்லினம் (soft/nasal consonants): ங ஞ ண ந ம ன'
  r.explanation = 'These six are called "soft" or "weak" consonants (nasals). All six are nasal sounds — air passes through the nose. Each nasal is paired with a hard consonant: ங pairs with க, ஞ with ச, ண with ட, ந with த, ம with ப, ன with ற. (Nannūl sutra 69)'
  r.english_translation = 'ங (ng), ஞ (ny), ண (ṇ), ந (n), ம (m), ன (n) — all nasal sounds'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson8, tamil_example: 'இடையினம் ய, ர, ல, வ, ழ, ள') do |r|
  r.rule_text = 'இடையினம் (middle consonants): ய ர ல வ ழ ள'
  r.explanation = 'These six are called "middle" consonants (liquids and glides). They sit between hard and soft in quality. ழ (zha) is unique to Tamil — found in no other language. (Nannūl sutra 70)'
  r.english_translation = 'ய (y), ர (r), ல (l), வ (v), ழ (zh — unique to Tamil), ள (ḷ)'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson8, tamil_example: 'க-ங, ச-ஞ, ட-ண, த-ந, ப-ம, ற-ன') do |r|
  r.rule_text = 'Each hard consonant is paired with its nasal counterpart'
  r.explanation = 'Nannūl groups consonants in pairs: each வல்லினம் has a corresponding மெல்லினம் produced at the same point in the mouth. க (back of throat) pairs with ங (same position, nasal). This pairing is important for understanding how sounds change in words. (Nannūl sutra 71)'
  r.english_translation = 'க/ங, ச/ஞ, ட/ண, த/ந, ப/ம, ற/ன — six pairs sharing articulation point'
end

# Lesson 9: Compound Letters — உயிர்மெய்
lesson9 = GrammarLesson.find_or_create_by!(title: 'Compound Letters — உயிர்மெய்') do |l|
  l.level = 'beginner'
  l.position = 9
  l.content = "When a consonant (மெய்) combines with a vowel (உயிர்), it forms a compound letter (உயிர்மெய்). The consonant provides the sound shape and the vowel provides its voice. This is how most Tamil syllables are written — a consonant+vowel unit written as a single character. 18 consonants × 12 vowels = 216 compound letters. (Nannūl sutra 89)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson9, tamil_example: 'க + அ = க | க + ஆ = கா | க + இ = கி | க + ஈ = கீ') do |r|
  r.rule_text = 'A consonant + vowel = one compound letter (உயிர்மெய்)'
  r.explanation = 'The consonant க combined with the vowel அ gives க (ka). With ஆ it gives கா (kā). With இ it gives கி (ki). The vowel mark attaches to the consonant to form one unified character. (Nannūl sutra 89)'
  r.english_translation = 'க+அ=க(ka), க+ஆ=கா(kā), க+இ=கி(ki), க+ஈ=கீ(kī)'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson9, tamil_example: 'மெய்ப் புள்ளி விட்டு உயிரோடு சேர்ந்து திரியும்') do |r|
  r.rule_text = 'The consonant dot (புள்ளி) disappears when a vowel joins'
  r.explanation = 'A consonant standing alone carries a dot above it (புள்ளி) — e.g. க் — showing it is "mute". When a vowel joins, the dot disappears and the vowel mark appears instead: க் + அ = க (the dot is replaced). (Nannūl sutra 89)'
  r.english_translation = 'க் (k, mute) + அ = க (ka) — the dot signals an unvoiced consonant'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson9, tamil_example: 'ப + அ = ப | ப + ஆ = பா | ப + உ = பு | ப + ஊ = பூ') do |r|
  r.rule_text = 'Practice: the consonant ப across 12 vowels'
  r.explanation = 'Every consonant can combine with all 12 vowels. For ப: ப(pa), பா(pā), பி(pi), பீ(pī), பு(pu), பூ(pū), பெ(pe), பே(pē), பை(pai), போ(pō), பொ(po), பௌ(pau). This pattern repeats for all 18 consonants.'
  r.english_translation = 'ப across 12 vowels: pa, pā, pi, pī, pu, pū, pe, pē, pai, pō, po, pau'
end

# Lesson 10: How Tamil Sounds Are Made — Phonology
lesson10 = GrammarLesson.find_or_create_by!(title: 'How Tamil Sounds Are Made — Phonology') do |l|
  l.level = 'intermediate'
  l.position = 10
  l.content = "Nannūl describes precisely where in the mouth each Tamil letter is produced. Understanding this helps correct pronunciation — especially for sounds like ழ, ண, ள, ற that have no equivalent in English or Hindi. Nannūl groups letters by their place of articulation: throat, palate, teeth, lips. (Nannūl sutras 74–86)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson10, tamil_example: 'அ, ஆ — வாய் திறப்பால் (by mere opening of the mouth)') do |r|
  r.rule_text = 'அ and ஆ are produced by simply opening the mouth'
  r.explanation = 'The vowels அ and ஆ require no specific tongue or lip movement — they arise from the open throat. அ is the natural sound of an open mouth, which is why it begins the alphabet and is said to be the beginning of all language. (Nannūl sutra 76)'
  r.english_translation = 'Open your mouth and breathe — that sound is அ'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson10, tamil_example: 'இ, ஈ, எ, ஏ, ஐ — அண்ணம் (palate)') do |r|
  r.rule_text = 'இ ஈ எ ஏ ஐ are palatal vowels — tongue touches upper palate'
  r.explanation = 'These vowels are formed with the tongue raised toward the hard palate. Notice the "ee" and "ay" quality in them. (Nannūl sutra 77)'
  r.english_translation = 'இ(i), ஈ(ī), எ(e), ஏ(ē), ஐ(ai) — front/palatal vowels'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson10, tamil_example: 'உ, ஊ, ஒ, ஓ, ஔ — இதழ் (lips)') do |r|
  r.rule_text = 'உ ஊ ஒ ஓ ஔ are labial vowels — formed with the lips'
  r.explanation = 'These vowels are formed by rounding the lips. Notice the "oo" and "oh" quality. (Nannūl sutra 78)'
  r.english_translation = 'உ(u), ஊ(ū), ஒ(o), ஓ(ō), ஔ(au) — back/labial vowels'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson10, tamil_example: 'ழ — அண்ணா நுனிநா தவலை (tongue tip curled back)') do |r|
  r.rule_text = 'ழ (zha) — produced by curling the tongue tip back toward the palate'
  r.explanation = 'The sound ழ is unique to Tamil (and Malayalam). It is produced by curling the tongue tip back and touching the roof of the mouth toward the back. It has no equivalent in Hindi, English, or Sanskrit. Mispronouncing it as "la" or "ra" is a common error. (Nannūl sutra 83)'
  r.english_translation = 'ழ has no English equivalent — tongue curls back, not forward like ல or ர'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson10, tamil_example: 'ற — அண்ண நுனிநா நலி (strong alveolar trill)') do |r|
  r.rule_text = 'ற is a strong trill — not the same as ர'
  r.explanation = 'ற is a strong retroflex/alveolar trill, much harder than ர. Tamil has two "r" sounds: ர (soft, as in "very") and ற (strong, as in a sharp trill). In spoken Tamil, especially in the south, this distinction is critical. (Nannūl sutra 86)'
  r.english_translation = 'ர = soft r | ற = strong trill r — these are different letters with different sounds'
end

# Lesson 11: The Aytham (ஃ)
lesson11 = GrammarLesson.find_or_create_by!(title: 'The Aytham — ஃ') do |l|
  l.level = 'intermediate'
  l.position = 11
  l.content = "The Aytham (ஃ) is a unique letter in Tamil with no equivalent in any other language. It appears between a short vowel and a hard consonant, and is written as three dots (ஃ). It represents a brief, soft glottal stop or aspiration. In modern Tamil it is rare, but in classical texts it appears frequently. (Nannūl sutra 90)"
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson11, tamil_example: 'அஃகம் (அஃ + கம்) — grain') do |r|
  r.rule_text = 'Aytham (ஃ) appears between a short vowel and a hard consonant'
  r.explanation = 'The Aytham only occurs after a short vowel (குறில்) and before a hard consonant (வல்லினம்). It represents a brief glottal catch — a slight pause before the hard consonant. Example: அஃகம் (grain), எஃகு (steel/sword). (Nannūl sutra 90)'
  r.english_translation = 'ஃ = a brief glottal stop before a hard consonant'
end

GrammarRule.find_or_create_by!(grammar_lesson: lesson11, tamil_example: 'எஃகு (steel) — appears in classical Tamil poetry') do |r|
  r.rule_text = 'Aytham is common in classical Tamil, rare in modern usage'
  r.explanation = 'In Sangam poetry and classical texts, the Aytham appears frequently — especially in words like எஃகு (steel, sword), அஃகம் (grain). In modern written Tamil it is mostly limited to the exclamation ஃ used to represent borrowed sounds. Recognising it helps when reading classical texts.'
  r.english_translation = 'எஃகு = steel/sword | அஃகம் = grain — classical Tamil vocabulary with Aytham'
end

puts "  #{GrammarLesson.count} grammar lessons, #{GrammarRule.count} grammar rules seeded"

# ============================================================
# READING PASSAGES
# ============================================================
puts "Seeding reading passages..."

ReadingPassage.find_or_create_by!(title: 'My Family - என் குடும்பம்') do |p|
  p.level = 'beginner'
  p.content = "என் பெயர் முரளி. என்னுடைய குடும்பத்தில் நான்கு பேர் இருக்கிறோம். என் அப்பா பெயர் ராஜன். என் அம்மா பெயர் லக்ஷ்மி. என் தங்கை பெயர் பிரியா. நாங்கள் சென்னையில் வாழ்கிறோம். என் அப்பா அலுவலகத்தில் வேலை செய்கிறார். என் அம்மா பள்ளியில் ஆசிரியை. நான் தினமும் பள்ளிக்கு போகிறேன்."
  p.translation = "My name is Murali. There are four people in my family. My father's name is Rajan. My mother's name is Lakshmi. My younger sister's name is Priya. We live in Chennai. My father works in an office. My mother is a teacher in a school. I go to school every day."
end

ReadingPassage.find_or_create_by!(title: 'The Market - சந்தை') do |p|
  p.level = 'beginner'
  p.content = "அம்மாவுடன் சந்தைக்கு போனேன். சந்தையில் நிறைய கடைகள் இருந்தன. காய்கறி கடையில் தக்காளி, வெங்காயம், கத்தரிக்காய் வாங்கினோம். பழக் கடையில் வாழைப்பழம் வாங்கினோம். தண்ணீர் குடித்தோம். வீட்டிற்கு திரும்பி வந்தோம்."
  p.translation = "I went to the market with mother. There were many shops in the market. At the vegetable shop, we bought tomatoes, onions, and brinjal. At the fruit shop, we bought bananas. We drank water. We came back home."
end

ReadingPassage.find_or_create_by!(title: 'The Seasons - பருவங்கள்') do |p|
  p.level = 'intermediate'
  p.content = "தமிழ் நாட்டில் ஆறு பருவங்கள் உண்டு. இளவேனில், முதுவேனில், கார், குளிர், முன்பனி, பின்பனி என்று அழைக்கப்படும். கார் காலத்தில் மழை பெய்யும். இளவேனிலில் மலர்கள் பூக்கும். குளிர் காலத்தில் குளிராக இருக்கும். ஒவ்வொரு பருவமும் தனித்தன்மை வாய்ந்தது."
  p.translation = "There are six seasons in Tamil Nadu. They are called Ilavenilam (early spring), Muthuvenilam (summer), Kaar (monsoon), Kulir (autumn), Munpani (early winter), Pinpani (late winter). In the monsoon season it rains. In spring, flowers bloom. In winter it is cold. Every season has its own uniqueness."
end

ReadingPassage.find_or_create_by!(title: 'Thirukkural - திருக்குறள்') do |p|
  p.level = 'classical'
  p.content = "அகர முதல எழுத்தெல்லாம் ஆதி\nபகவன் முதற்றே உலகு.\n\nகற்க கசடற கற்பவை கற்றபின்\nநிற்க அதற்குத் தக.\n\nயாதும் ஊரே யாவரும் கேளிர்\nதீதும் நன்றும் பிறர்தர வாரா."
  p.translation = "All letters begin with அ; so too the world begins with God.\n\nLearn thoroughly what is worth learning; having learned, live accordingly.\n\nEvery place is my hometown, every person is my kin; suffering and happiness do not come from others — they come from within."
end

puts "  #{ReadingPassage.count} reading passages seeded"

# ============================================================
# QUIZ QUESTIONS
# ============================================================
puts "Seeding quiz questions..."

quiz_questions = [
  # Beginner
  { question: 'What does "வணக்கம்" mean?', options: ['Hello', 'Goodbye', 'Thank you', 'Please'], correct_index: 0, level: 'beginner', category: 'vocabulary' },
  { question: 'How do you say "Thank you" in Tamil?', options: ['மன்னிக்கவும்', 'நன்றி', 'தயவுசெய்து', 'வணக்கம்'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'What number is "மூன்று"?', options: ['Two', 'Three', 'Four', 'Five'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'Which letter is this: அ?', options: ['a', 'i', 'u', 'e'], correct_index: 0, level: 'beginner', category: 'alphabet' },
  { question: 'What does "அம்மா" mean?', options: ['Father', 'Mother', 'Sister', 'Brother'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'How do you say "Yes" in Tamil?', options: ['இல்லை', 'ஆம்', 'நன்றி', 'வணக்கம்'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'What color is "சிவப்பு"?', options: ['Blue', 'Green', 'Red', 'Yellow'], correct_index: 2, level: 'beginner', category: 'vocabulary' },
  { question: 'What does "வீடு" mean?', options: ['School', 'House', 'Market', 'Temple'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'How do you say "Water" in Tamil?', options: ['பால்', 'தண்ணீர்', 'காபி', 'தேநீர்'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  { question: 'What does "நாய்" mean?', options: ['Cat', 'Dog', 'Cow', 'Horse'], correct_index: 1, level: 'beginner', category: 'vocabulary' },
  # Intermediate
  { question: 'What is the Tamil sentence word order?', options: ['Subject-Verb-Object', 'Subject-Object-Verb', 'Verb-Subject-Object', 'Object-Verb-Subject'], correct_index: 1, level: 'intermediate', category: 'grammar' },
  { question: 'Which pronoun is formal: "நீ" or "நீங்கள்"?', options: ['நீ', 'நீங்கள்', 'Both are formal', 'Neither'], correct_index: 1, level: 'intermediate', category: 'grammar' },
  { question: 'What does "எப்படி இருக்கிறீர்கள்?" mean?', options: ['What is your name?', 'How are you?', 'Where are you?', 'When will you come?'], correct_index: 1, level: 'intermediate', category: 'vocabulary' },
  { question: 'What does "நேற்று" mean?', options: ['Today', 'Tomorrow', 'Yesterday', 'Now'], correct_index: 2, level: 'intermediate', category: 'vocabulary' },
  { question: 'Which letter represents the "zha" sound unique to Tamil?', options: ['ல்', 'ள்', 'ழ்', 'ற்'], correct_index: 2, level: 'intermediate', category: 'alphabet' },
  { question: 'What does "சந்திரன்" mean?', options: ['Sun', 'Moon', 'Star', 'Sky'], correct_index: 1, level: 'intermediate', category: 'vocabulary' },
  { question: 'How do you say "Hundred" in Tamil?', options: ['பத்து', 'இருபது', 'நூறு', 'ஆயிரம்'], correct_index: 2, level: 'intermediate', category: 'vocabulary' },
  { question: 'What suffix means "to" or "for" in Tamil?', options: ['-இல்', '-க்கு', '-உம்', '-ஆல்'], correct_index: 1, level: 'intermediate', category: 'grammar' },
  { question: 'What is the Tamil word for "Library"?', options: ['அலுவலகம்', 'பள்ளி', 'நூலகம்', 'உணவகம்'], correct_index: 2, level: 'intermediate', category: 'vocabulary' },
  { question: 'How do you say "Good morning" in Tamil?', options: ['நல்ல மாலை', 'இனிய இரவு', 'நல்ல காலை', 'வணக்கம்'], correct_index: 2, level: 'intermediate', category: 'vocabulary' },
  # Advanced
  { question: 'Translate: "I went to the market yesterday"', options: ['நான் நேற்று சந்தைக்கு போனேன்', 'நான் நாளை சந்தைக்கு போவேன்', 'நான் இன்று சந்தைக்கு போகிறேன்', 'நான் சந்தையில் இருக்கிறேன்'], correct_index: 0, level: 'advanced', category: 'grammar' },
  { question: 'What is the difference between "நாம்" and "நாங்கள்"?', options: ['They mean the same thing', 'நாம் is formal', 'நாம் includes the listener, நாங்கள் excludes the listener', 'நாம் is singular'], correct_index: 2, level: 'advanced', category: 'grammar' },
  { question: 'What does the suffix "-உம்" mean?', options: ['Past tense', 'Plural', 'Also/And', 'Formal'], correct_index: 2, level: 'advanced', category: 'grammar' },
  { question: 'What is the present tense marker in Tamil?', options: ['-த்த-', '-கிற-', '-வ-', '-ட்ட-'], correct_index: 1, level: 'advanced', category: 'grammar' },
  { question: 'What does "யாதும் ஊரே யாவரும் கேளிர்" mean?', options: ['God is everywhere', 'Every place is home, everyone is family', 'Learn and live accordingly', 'All letters begin with அ'], correct_index: 1, level: 'advanced', category: 'classical' },
  { question: 'Tolkāppiyam is primarily a treatise on?', options: ['History', 'Religion', 'Grammar and poetics', 'Mathematics'], correct_index: 2, level: 'advanced', category: 'classical' },
  { question: 'How many Kurals are in Thirukkural?', options: ['1000', '1330', '1008', '1440'], correct_index: 1, level: 'advanced', category: 'classical' },
  { question: 'How do you say "Can you help me?" in Tamil?', options: ['நீங்கள் எனக்கு உதவ முடியுமா?', 'நான் உங்களுக்கு உதவுகிறேன்', 'உதவி வேண்டாம்', 'நீங்கள் யார்?'], correct_index: 0, level: 'advanced', category: 'vocabulary' },
  { question: 'What does "வாழ்க" mean?', options: ['Die', 'May you live long', 'Come here', 'Go away'], correct_index: 1, level: 'advanced', category: 'classical' },
  { question: 'How many basic vowels are in Tamil?', options: ['5', '10', '12', '15'], correct_index: 2, level: 'advanced', category: 'alphabet' }
]

quiz_questions.each do |q|
  QuizQuestion.find_or_create_by!(question: q[:question]) do |r|
    r.assign_attributes(q)
  end
end

puts "  #{QuizQuestion.count} quiz questions seeded"

# ============================================================
# ACHIEVEMENTS
# ============================================================
puts "Seeding achievements..."

achievements = [
  { name: 'First Word', description: 'Learn your first Tamil word', icon: '🎉', condition_key: 'words_learned', threshold: 1 },
  { name: 'Word Explorer', description: 'Learn 10 words', icon: '📚', condition_key: 'words_learned', threshold: 10 },
  { name: 'Word Master', description: 'Learn 50 words', icon: '📖', condition_key: 'words_learned', threshold: 50 },
  { name: 'Word Champion', description: 'Learn 100 words', icon: '🎓', condition_key: 'words_learned', threshold: 100 },
  { name: 'Alphabet Starter', description: 'Learn 10 letters', icon: '🔤', condition_key: 'letters_learned', threshold: 10 },
  { name: 'Alphabet Master', description: 'Learn all 30 basic letters', icon: '🏆', condition_key: 'letters_learned', threshold: 30 },
  { name: 'Quiz Taker', description: 'Complete your first quiz', icon: '✅', condition_key: 'quizzes_completed', threshold: 1 },
  { name: 'Quiz Expert', description: 'Complete 10 quizzes', icon: '🎯', condition_key: 'quizzes_completed', threshold: 10 },
  { name: 'Week Warrior', description: '7-day study streak', icon: '🔥', condition_key: 'streak_days', threshold: 7 },
  { name: 'Monthly Master', description: '30-day study streak', icon: '⭐', condition_key: 'streak_days', threshold: 30 },
  { name: 'Dedicated Learner', description: 'Study for 60 minutes total', icon: '⏰', condition_key: 'study_time_minutes', threshold: 60 },
  { name: 'Tamil Scholar', description: 'Study for 300 minutes total', icon: '👨‍🎓', condition_key: 'study_time_minutes', threshold: 300 }
]

achievements.each { |a| Achievement.find_or_create_by!(name: a[:name]) { |r| r.assign_attributes(a) } }
puts "  #{Achievement.count} achievements seeded"

# ============================================================
# GRAMMAR LESSONS — சொல்லதிகாரம் (Sollatikaram) Part I
# Nannūl sutras 261–266: Noun Classes, Gender, Number, Person
# ============================================================
puts "Seeding Sollatikaram grammar lessons..."

# -------------------------------------------------------
# Lesson 12: Tamil Noun Classes — உயர்திணை and அஃறிணை
# -------------------------------------------------------
lesson12 = GrammarLesson.find_or_create_by!(title: 'Tamil Noun Classes — உயர்திணை and அஃறிணை') do |l|
  l.level = 'intermediate'
  l.position = 12
  l.content = <<~TEXT
    Every Tamil noun belongs to one of two classes (திணை, tiṇai). நன்னூல் sutra 261 states the rule: மக்கள், தேவர், நரகர் — humans and divine/demonic beings — are உயர்திணை (uvar-tiṇai), the "high" or rational class. Everything else — animals, plants, objects, abstractions — is அஃறிணை (aḵṟiṇai), the "low" or irrational class. This distinction is not optional; it controls which pronouns and verb endings you use, and misusing it marks you as a non-native speaker. Sutras 262–263 refine each class: உயர்திணை divides into ஆண்பால் (masculine singular), பெண்பால் (feminine singular), and பலர்பால் (plural of both); அஃறிணை divides into ஒன்றன்பால் (singular) and பலவின்பால் (plural).
  TEXT
end

[
  {
    rule_text: 'மக்கள், தேவர், நரகர் — உயர்திணை; மற்றுயர் உள்ளவும் அஃறிணை.',
    explanation: 'Humans, gods, and demons are உயர்திணை (rational class). All remaining beings and things belong to அஃறிணை (irrational class). The dividing line is rational personhood, not size or importance. A king is உயர்திணை; an elephant (however majestic) is அஃறிணை.',
    tamil_example: 'அவன் வந்தான். (உயர்திணை — he came.) | அது வந்தது. (அஃறிணை — it came.)',
    english_translation: 'He came. (rational) | It came. (irrational)'
  },
  {
    rule_text: 'ஆண், பெண், பலர் என்று மூப்பாற் றுர்திணை — உயர்திணை மூவகை.',
    explanation: 'The rational class (உயர்திணை) has three sub-genders: ஆண்பால் (masculine singular — அவன்), பெண்பால் (feminine singular — அவள்), and பலர்பால் (plural — அவர்). There is no neuter person in the rational class.',
    tamil_example: 'ஆண்பால்: அவன் | பெண்பால்: அவள் | பலர்பால்: அவர்கள்',
    english_translation: 'Masculine: he | Feminine: she | Plural (rational): they'
  },
  {
    rule_text: 'ஒன்றே, பல என் றிருபாற் றஃறிணை — அஃறிணை இருவகை.',
    explanation: 'The irrational class (அஃறிணை) has only two numbers: ஒன்றன்பால் (singular — அது, "it") and பலவின்பால் (plural — அவை, "they/those"). Unlike உயர்திணை, அஃறிணை makes no distinction of gender.',
    tamil_example: 'ஒன்றன்பால்: அது (it) | பலவின்பால்: அவை (they, of things)',
    english_translation: 'Singular irrational: it | Plural irrational: they (things)'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson12) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 13: Gender, Number, and the Three Persons
# -------------------------------------------------------
lesson13 = GrammarLesson.find_or_create_by!(title: 'Gender, Number, and the Three Persons') do |l|
  l.level = 'intermediate'
  l.position = 13
  l.content = <<~TEXT
    Tamil grammar organises all nouns and verbs around three overlapping systems: gender (பால், pāl), number (எண், eṇ), and person (இடம், iṭam). Sutra 266 defines the three persons: தன்மை (1st person — I/we), முன்னிலை (2nd person — you), and படர்க்கை (3rd person — he/she/it/they). Sutra 285 lists the pronouns for each person, and sutra 287 explains singular vs plural for each. Understanding this three-way grid is essential: every Tamil finite verb agrees with its subject in all three dimensions simultaneously — person, number, and (for 3rd person) gender.
  TEXT
end

[
  {
    rule_text: 'தன்மை, முன்னிலை, படர்க்கை — மூவிடம். (சூ. 266)',
    explanation: 'Tamil has three grammatical persons: தன்மை (1st — the speaker: யான் "I", நாம் "we"), முன்னிலை (2nd — the addressee: நீ "you singular", நீர்/நீவிர் "you plural/respectful"), and படர்க்கை (3rd — everyone else: அவன், அவள், அவர், அது, அவை). Every finite verb ending reflects the person of the subject.',
    tamil_example: 'யான் படிக்கிறேன். | நீ படிக்கிறாய். | அவன் படிக்கிறான்.',
    english_translation: 'I am reading. | You are reading. | He is reading.'
  },
  {
    rule_text: 'தன்மை: யான், நான், யாம், நாம்; முன்னிலை: எல்லீர், நீயிர், நீவிர், நீர், நீ. (சூ. 285)',
    explanation: '1st person singular: யான் / நான் (I); 1st person plural inclusive: நாம் (we including the listener); 1st person plural exclusive: யாம் (we not including the listener). 2nd person ranges from intimate நீ to respectful நீர் to formal நீவிர் / நீயிர். The choice carries social register.',
    tamil_example: 'நான் வருகிறேன். (I come.) | நாம் வருகிறோம். (We come.) | நீ வா. (You come — intimate command.)',
    english_translation: 'I come. | We come. | Come (you — intimate).'
  },
  {
    rule_text: 'படர்க்கை: அவன் (masc. sg.), அவள் (fem. sg.), அவர் (hon./pl.), அது (irrational sg.), அவை (irrational pl.)',
    explanation: 'Third person in Tamil encodes both gender class and number in the pronoun itself. அவன் (rational masculine singular), அவள் (rational feminine singular), அவர் (rational plural or honorific singular), அது (irrational singular), அவை (irrational plural). Using the wrong pronoun is a serious grammatical error.',
    tamil_example: 'அவன் சென்றான். | அவள் சென்றாள். | அவர் சென்றார். | அது சென்றது. | அவை சென்றன.',
    english_translation: 'He went. | She went. | They/He (hon.) went. | It went. | They (things) went.'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson13) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 14: The Eight Cases — வேற்றுமை
# -------------------------------------------------------
lesson14 = GrammarLesson.find_or_create_by!(title: 'The Eight Cases — வேற்றுமை') do |l|
  l.level = 'intermediate'
  l.position = 14
  l.content = <<~TEXT
    Tamil is a highly inflected language — nouns change their endings to show grammatical function. நன்னூல் sutra 291 states there are eight cases (வேற்றுமை, vēṟṟumai), and sutra 292 names their case markers in order: பெயரே (nominative — the noun itself, no marker), ஐ (accusative), ஆல் (instrumental), கு (dative), இன் (ablative), அது (genitive), கண் (locative), and விளி (vocative). These markers attach to the noun stem (sometimes with a linking vowel சாரியை). Mastering the eight cases unlocks the ability to read any Tamil sentence — including Thirukkural and Purananuru.
  TEXT
end

[
  {
    rule_text: 'வேற்றுமை எட்டே. (சூ. 291) — எட்டு வேற்றுமை உண்டு.',
    explanation: 'Tamil has eight cases. Each case expresses a specific grammatical relationship between a noun and the rest of the sentence. Unlike English (which uses word order and prepositions), Tamil attaches case suffixes directly to the noun stem. The 8 cases are: 1. எழுவாய் (nominative), 2. ஐ (accusative), 3. ஆல்/ஒடு (instrumental), 4. கு (dative), 5. இன் (ablative), 6. அது/இன் (genitive), 7. கண் (locative), 8. விளி (vocative).',
    tamil_example: 'ராமன் (nom.) | ராமனை (acc.) | ராமனால் (instr.) | ராமனுக்கு (dat.) | ராமனிடமிருந்து (abl.) | ராமனின் (gen.) | ராமனிடம் (loc.) | ராமா! (voc.)',
    english_translation: 'Raman (subj.) | Raman (obj.) | by Raman | to/for Raman | from Raman | of Raman | at/in Raman | O Raman!'
  },
  {
    rule_text: 'பெயரே, ஐ, ஆல், கு, இன், அது, கண் — விளி என நாகும், அவற்றின் பெயர், முறை. (சூ. 292)',
    explanation: 'The eight case markers in order: (1) பெயரே — the nominative is the noun itself, unmarked; (2) ஐ — accusative; (3) ஆல் — instrumental; (4) கு — dative; (5) இன் — ablative; (6) அது — genitive; (7) கண் — locative; (8) விளி — vocative. Each marker may appear in slightly varied forms depending on the noun ending, and a சாரியை (euphonic linking element) often appears between the stem and the marker.',
    tamil_example: 'மரம் | மரத்தை | மரத்தால் | மரத்திற்கு | மரத்திலிருந்து | மரத்தின் | மரத்தில் | மரமே!',
    english_translation: 'tree (nom.) | tree (acc.) | by/with tree | for/to tree | from tree | of tree | in/on tree | O tree!'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson14) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 15: Cases 1–4 in Detail
# -------------------------------------------------------
lesson15 = GrammarLesson.find_or_create_by!(title: 'Cases 1–4: Nominative, Accusative, Instrumental, Dative') do |l|
  l.level = 'intermediate'
  l.position = 15
  l.content = <<~TEXT
    நன்னூல் sutras 295–298 give the meanings of the first four cases. The nominative (எழுவாய்) is the subject — the noun itself, unchanged. The accusative (இரண்டாம் வேற்றுமை, marker ஐ) marks the direct object of a verb. The instrumental (மூன்றாம் வேற்றுமை, marker ஆல் or ஒடு) marks the instrument of an action or accompaniment. The dative (நான்காம் வேற்றுமை, marker கு) marks the recipient, purpose, or beneficiary.
  TEXT
end

[
  {
    rule_text: 'எழுவாய் (1st case) — உரு திரிவில் பெயரே. (சூ. 295)',
    explanation: 'The nominative case is the noun in its base form — no suffix is added. It marks the subject of a sentence: the noun that performs or undergoes the action. In Tamil, the subject (எழுவாய்) usually comes first in the sentence, before the object and verb.',
    tamil_example: 'குழந்தை விளையாடுகிறது.',
    english_translation: 'The child is playing. (குழந்தை = subject, nominative)'
  },
  {
    rule_text: 'இரண்டாம் வேற்றுமை (2nd case/Accusative) — இரண்டா வதன்உரு பையே. (சூ. 296)',
    explanation: 'The accusative case (marker: ஐ) marks the direct object — the noun that receives the action. It corresponds to the English "whom" or "what" in "I see him" / "She eats rice." The ஐ suffix attaches after a சாரியை if required by the noun stem.',
    tamil_example: 'நான் மாம்பழத்தை சாப்பிட்டேன்.',
    english_translation: 'I ate the mango. (மாம்பழத்தை = mango + ஐ accusative)'
  },
  {
    rule_text: 'மூன்றாம் வேற்றுமை (3rd case/Instrumental) — மூன்றா வதன்உரு ஆன், ஒடு. (சூ. 297)',
    explanation: 'The instrumental case (markers: ஆல் or ஒடு) expresses (1) the instrument by which something is done (ஆல்: "by means of"), (2) cause or reason (ஆல்: "because of"), and (3) accompaniment (ஒடு: "together with / along with"). The two markers are not interchangeable: ஆல் stresses means/cause, ஒடு stresses company.',
    tamil_example: 'மண்ணால் குடம் செய்தான். (ஆல் — instrument) | நண்பனோடு சென்றான். (ஒடு — accompaniment)',
    english_translation: 'He made a pot with clay. | He went with a friend.'
  },
  {
    rule_text: 'நான்காம் வேற்றுமை (4th case/Dative) — நான்கா வதன்உரு பாங்கு கு. (சூ. 298)',
    explanation: 'The dative case (marker: கு, appearing as க்கு after many stems) marks: (1) the indirect object / recipient (கொடை — "giving to"), (2) purpose or benefit (பொருட்டு — "for the sake of"), (3) aptness or fitness (தகவது — "befitting"), (4) cause (ஆதல் — "becoming"). It is the most versatile case after the nominative.',
    tamil_example: 'அவனுக்கு புத்தகம் கொடுத்தேன். (recipient) | நாட்டிற்காக போரிட்டான். (purpose)',
    english_translation: 'I gave him a book. (to him) | He fought for the country. (for)'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson15) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 16: Cases 5–8 in Detail
# -------------------------------------------------------
lesson16 = GrammarLesson.find_or_create_by!(title: 'Cases 5–8: Ablative, Genitive, Locative, Vocative') do |l|
  l.level = 'intermediate'
  l.position = 16
  l.content = <<~TEXT
    நன்னூல் sutras 299–302 complete the eight cases. The ablative (5th case, marker இன் / இல்) indicates separation, comparison, or source. The genitive (6th case, marker இன் / அது / உடைய) marks possession or relationship. The locative (7th case, marker கண் / இல்) marks location. The vocative (8th case, விளி) addresses someone directly and takes no suffix — it is simply the noun (or noun + ஏ for emphasis). Together these eight cases cover every grammatical relationship a noun can have in a Tamil sentence.
  TEXT
end

[
  {
    rule_text: 'ஐந்தாம் வேற்றுமை (5th case/Ablative) — ஐந்தா வதன்உரு பிற்கும் இன்னும். (சூ. 299)',
    explanation: 'The ablative case (marker: இன் or இல்) expresses (1) separation / departure from (நீங்கல்: "going away from"), (2) comparison (ஒப்பெல்லை: "more than / less than"), and (3) cause or reason (ஏது: "because of"). It answers the question "from where?" or "than what?"',
    tamil_example: 'ஊரிலிருந்து வந்தான். (from the town) | அவனிலும் தாள் உயர்ந்தவன். (taller than him)',
    english_translation: 'He came from the town. (ablative: separation) | He is taller than him. (ablative: comparison)'
  },
  {
    rule_text: 'ஆறாம் வேற்றுமை (6th case/Genitive) — ஆறன் ஒருமைக் கதுவும் ஆதலும். (சூ. 300)',
    explanation: 'The genitive case (markers: இன், அது, or the postposition உடைய) marks possession and relationship: "X of Y" or "Y\'s X". In modern Tamil, the genitive often appears as -இன் after consonant-ending stems or -ஐ/-ஓ in compounds. Classical Tamil uses a wider range of forms.',
    tamil_example: 'அவனுடைய வீடு. | ராமனின் தம்பி.',
    english_translation: 'His house. (of him) | Raman\'s younger brother. (of Raman)'
  },
  {
    rule_text: 'ஏழாம் வேற்றுமை (7th case/Locative) — ஏழாம் வேற்றுமை இடம் பொருள் குறித்து கண்/இல். (சூ. 301)',
    explanation: 'The locative case (markers: கண் in classical Tamil; இல் / இடம் in modern) marks location — where something exists or occurs. It answers the question "where?" (எங்கே?). கண் appears frequently in Sangam and classical poetry; இல் / இடம் are used in modern spoken and written Tamil.',
    tamil_example: 'மரத்தில் பறவை இருக்கிறது. (modern) | அவன்கண் அறிவு உண்டு. (classical)',
    english_translation: 'There is a bird in the tree. | There is wisdom in him. (classical locative கண்)'
  },
  {
    rule_text: 'எட்டாம் வேற்றுமை — விளி (Vocative) — addressed form, the noun alone or + ஏ.',
    explanation: 'The vocative (விளி) is used to address someone directly. In Tamil, the vocative is usually the noun itself with no special suffix, or the noun followed by the particle ஏ for emphasis. It does not change the noun stem. Sangam poetry is full of vocatives: "தோழி!" (O friend!), "அம்மா!" (O mother!), "மரமே!" (O tree!)',
    tamil_example: 'அப்பா, வாருங்கள்! | இராமா, இங்கே வா! | மரமே, உனக்கு வணக்கம்!',
    english_translation: 'Father, please come! | O Rama, come here! | O tree, I salute you!'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson16) do |gr|
    gr.assign_attributes(r)
  end
end

# ============================================================
# GRAMMAR LESSONS — சொல்லதிகாரம் (Sollatikaram) Part II
# Nannūl sutras 320–338: Verbs, Tenses, Conjugation
# ============================================================

# -------------------------------------------------------
# Lesson 17: What is a Tamil Verb? — வினை
# -------------------------------------------------------
lesson17 = GrammarLesson.find_or_create_by!(title: 'What is a Tamil Verb? — வினை') do |l|
  l.level = 'intermediate'
  l.position = 17
  l.content = <<~TEXT
    நன்னூல் sutra 320 defines a verb (வினை) as the word that conveys six things simultaneously: செய்பவன் (the agent), கருவி (the instrument), நிலம் (the place), செயல் (the action), காலம் (the tense/time), and செய்பொருள் (the object). Sutra 322 classifies verb forms: முற்று (the finite verb — the complete predicate of a sentence), பெயரெச்சம் (verbal noun / relative participle), வினையெச்சம் (adverbial participle), and வினைக்குறிப்பு (indicator verbs). The finite verb (முற்றுவினை) is the backbone of every Tamil sentence — it alone can stand as a complete predicate, and it agrees with its subject in person, number, and gender/class.
  TEXT
end

[
  {
    rule_text: 'செய்பவன், கருவி, நிலஞ், செயல், காலஞ், செய்பொருள், ஆறும், தருவது வினையே. (சூ. 320)',
    explanation: 'A Tamil verb (வினை) simultaneously encodes six pieces of information: the agent (who acts), the instrument (by what means), the place (where), the action (what is done), the time (when — i.e., tense), and the object (what is acted upon). This is why Tamil verbs are so information-dense compared to English.',
    tamil_example: 'நான் நேற்று வீட்டில் சாப்பிட்டேன்.',
    english_translation: 'I ate at home yesterday. (agent=I, place=home, tense=past, action=ate — all in the verb form சாப்பிட்டேன்)'
  },
  {
    rule_text: 'முற்றும், பெயர்வினை எச்சமும், ஆகி ஒன்றற் குரியவும் பொதுவும் ஆகும். (சூ. 322)',
    explanation: 'Tamil verb forms are classified as: முற்றுவினை (finite verb — complete predicate), பெயரெச்சம் (verbal noun/relative participle — used to modify nouns), வினையெச்சம் (adverbial participle — joins clauses), and பொதுவினை (common forms used for both). Only the முற்றுவினை can end a sentence independently.',
    tamil_example: 'வந்தான் (முற்று — he came) | வந்தவன் (பெயரெச்சம் — he who came) | வந்து (வினையெச்சம் — having come)',
    english_translation: 'He came. (finite) | He who came. (relative participle) | Having come... (adverbial participle)'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson17) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 18: The Three Tenses — மூன்று காலம்
# -------------------------------------------------------
lesson18 = GrammarLesson.find_or_create_by!(title: 'The Three Tenses — மூன்று காலம்') do |l|
  l.level = 'intermediate'
  l.position = 18
  l.content = <<~TEXT
    Tamil has three tenses: இறந்தகாலம் (past), நிகழ்காலம் (present), and எதிர்காலம் (future). நன்னூல் sutra 324 states there are 27 finite verb forms across three tenses, three persons, and five gender-number categories. The tense is marked by an infix called the காலக்குறி (tense marker) that appears between the verb root and the personal ending. The past marker is typically -த்-/-ந்த்-/-ட்-/-ற்-; the present marker is -கிற்-/-கின்ற்-; the future marker is -ப்-/-வ்-. Knowing the three tense markers is the single most useful key to reading Tamil sentences.
  TEXT
end

[
  {
    rule_text: 'இறந்தகாலம் (Past tense) — action completed before the moment of speaking.',
    explanation: 'The past tense marker appears as -த்-, -ந்த்-, -ட்-, or -ற்- depending on the verb class. The personal ending is then added: -ஏன் (I), -ஓம் (we), -ஆய் (you sg.), -ஈர் (you pl.), -ஆன் (he), -ஆள் (she), -ஆர் (they/hon.), -த்து (it), -ன (they-things).',
    tamil_example: 'நடந்தேன் (I walked) | நடந்தாய் (you walked) | நடந்தான் (he walked) | நடந்தது (it walked/moved)',
    english_translation: 'Past tense of நட (to walk): I walked / you walked / he walked / it moved'
  },
  {
    rule_text: 'நிகழ்காலம் (Present tense) — action happening now or habitually.',
    explanation: 'The present tense marker is -கிற்- or -கின்ற்-. In spoken Tamil -கிற்- is standard (நடக்கிறேன்); in classical/literary Tamil -கின்ற்- appears (நடக்கின்றேன்). The same personal endings attach: -ேன், -ோம், -ாய், -ீர், -ான், -ாள், -ார், -து, -ன.',
    tamil_example: 'நடக்கிறேன் (I walk/am walking) | நடக்கிறாய் (you walk) | நடக்கிறான் (he walks) | நடக்கிறது (it moves)',
    english_translation: 'Present tense of நட: I am walking / you walk / he walks / it moves'
  },
  {
    rule_text: 'எதிர்காலம் (Future tense) — action that will happen.',
    explanation: 'The future tense marker is -ப்- or -வ்-. It expresses what will happen or what is intended. Personal endings attach: -ேன், -ோம், -ாய், -ீர், -ான், -ாள், -ார், -ும் (both classes for it/they). Note: future -ும் (படர்க்கை அஃறிணை) is the same form as the habitual/general present in some contexts.',
    tamil_example: 'நடப்பேன் (I will walk) | நடப்பாய் (you will walk) | நடப்பான் (he will walk) | நடக்கும் (it will move)',
    english_translation: 'Future tense of நட: I will walk / you will walk / he will walk / it will move'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson18) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 19: The 27 Finite Verb Endings — வினைமுற்று
# -------------------------------------------------------
lesson19 = GrammarLesson.find_or_create_by!(title: 'The 27 Finite Verb Endings — வினைமுற்று') do |l|
  l.level = 'intermediate'
  l.position = 19
  l.content = <<~TEXT
    நன்னூல் sutra 324 states that the finite verb (தெரிநிலை வினைமுற்று) has 27 forms: 3 tenses × (5 படர்க்கை forms + 2 தன்மை forms + 2 முன்னிலை forms). Sutras 325–329 give the personal endings for each gender/number. The படர்க்கை (3rd person) endings encode gender and class: -அன்/-ஆன் (masc. sg.), -அள்/-ஆள் (fem. sg.), -அர்/-ஆர் (rational pl.), -து/-ட்டு/-ற்று (irrational sg.), -அ/-ஆ/-ன/-ன்ன (irrational pl.). The தன்மை (1st person) endings are -ேன் (sg.) and -ோம் (pl.). The முன்னிலை (2nd person) endings are -ாய்/-ஐ (sg.) and -ீர்/-ீர்கள் (pl.).
  TEXT
end

[
  {
    rule_text: 'படர்க்கை ஆண்பால் (3rd masc. sg.): -அன் / -ஆன். (சூ. 325)',
    explanation: 'The masculine singular third-person ending is -அன் (short form, classical) or -ஆன் (long form, common). It attaches after the tense marker. This ending appears thousands of times in Sangam poetry: "வந்தான்" (he came), "சென்றான்" (he went), "உண்டான்" (he ate).',
    tamil_example: 'சென்றான் (he went-past) | செல்கின்றான் (he goes-present) | செல்வான் (he will go-future)',
    english_translation: 'He went / He goes / He will go'
  },
  {
    rule_text: 'படர்க்கை பெண்பால் (3rd fem. sg.): -அள் / -ஆள். (சூ. 326)',
    explanation: 'The feminine singular third-person ending is -அள் or -ஆள். Parallel to the masculine but marks female subjects. In classical Tamil the short form -அள் is more common in poetry; -ஆள் is standard in modern Tamil.',
    tamil_example: 'சென்றாள் (she went) | செல்கின்றாள் (she goes) | செல்வாள் (she will go)',
    english_translation: 'She went / She goes / She will go'
  },
  {
    rule_text: 'படர்க்கை பலர்பால் (3rd rational pl.): -அர் / -ஆர்; -மார் வினையொடு முடியும். (சூ. 327)',
    explanation: 'The rational plural third-person ending is -அர்/-ஆர். This covers "they" for humans (and honorific "he/she" for respected individuals). In classical poetry -ஆர் is the standard form. With the verb முடி (end) it can also form -மார் (poetic/archaic).',
    tamil_example: 'சென்றார் (they went / he/she went — honorific) | வருகின்றார் (they come) | வருவார் (they will come)',
    english_translation: 'They went (or: he/she went — honorific) / They come / They will come'
  },
  {
    rule_text: 'படர்க்கை ஒன்றன்பால் (3rd irrational sg.): -து / -டு / -ற்று. (சூ. 328)',
    explanation: 'The irrational singular ending is -து (after most stems), -டு (after certain stems), or -ற்று (after stems ending in certain consonants). It covers all irrational (animal, object, concept) singular subjects. This form is very common: "வந்தது" (it came), "ஆனது" (it became), "நடந்தது" (it happened).',
    tamil_example: 'வந்தது (it came) | வருகிறது (it comes) | வரும் (it will come)',
    english_translation: 'It came / It comes / It will come'
  },
  {
    rule_text: 'தன்மை (1st person): sg. -ேன்/-என்; pl. -ோம்/-ஓம். (சூ. 331–332)',
    explanation: '1st person singular ending is -ேன் (standard) or -என் (classical/short). 1st person plural is -ோம். These attach directly after the tense marker: past சென்றேன் / சென்றோம்; present செல்கிறேன் / செல்கிறோம்; future செல்வேன் / செல்வோம்.',
    tamil_example: 'சென்றேன் (I went) | சென்றோம் (we went) | வருகிறேன் (I am coming) | வருவேன் (I will come)',
    english_translation: 'I went / We went / I am coming / I will come'
  },
  {
    rule_text: 'முன்னிலை (2nd person): sg. -ஆய்/-ஐ; pl. -ஈர்/-ஈர்கள். (சூ. 335–337)',
    explanation: '2nd person singular is -ஆய் (common) or -ஐ (classical). 2nd person plural / respectful is -ஈர் or -ஈர்கள். Past: சென்றாய் / சென்றீர்; present: செல்கிறாய் / செல்கிறீர்; future: செல்வாய் / செல்வீர். The imperative (command) uses the bare verb root (நட! — walk!) or adds -உ for the 2nd plural (நடவுங்கள்!).',
    tamil_example: 'சென்றாய் (you went-sg.) | சென்றீர் (you went-pl./hon.) | வா! (come!-sg.) | வாருங்கள்! (come!-pl.)',
    english_translation: 'You went (sg.) / You went (pl./honorific) / Come! (sg.) / Come! (pl.)'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson19) do |gr|
    gr.assign_attributes(r)
  end
end

# -------------------------------------------------------
# Lesson 20: The Optative and Negative Verb
# -------------------------------------------------------
lesson20 = GrammarLesson.find_or_create_by!(title: 'The Optative (வியங்கோள்) and Negative Verb') do |l|
  l.level = 'intermediate'
  l.position = 20
  l.content = <<~TEXT
    Beyond the three tenses, Tamil has additional mood forms. நன்னூல் sutra 338 describes the வியங்கோள் (optative/benedictive mood) — the form used for wishes, blessings, and gentle commands. Its marker is -க or -ய or -வொடு. It is invariant for person, number, and gender — one form covers all. The negative in Tamil is typically formed with the negative particle இல்லை (is not) or by negating the verb with the negative verb form (negative finite verb uses -ஆ- infix or forms with இல், இலன், இல்லன், இல்லள், இல்லார், etc.). Classical Tamil uses different negative forms than modern Tamil.
  TEXT
end

[
  {
    rule_text: 'வியங்கோள் (Optative/Benedictive) — க, ய, வொடு ஆகற் நீற்ற வியங்கோள். (சூ. 338)',
    explanation: 'The வியங்கோள் (optative) expresses wishes, blessings, and polite commands. Marker: -க (most common), -ய, or -வொடு. Crucially, it is the SAME form for all persons, numbers, and genders — no agreement required. This is why Tamil blessings and proverbs often use this form: "வாழ்க!" (may he/she/they/you live long!), "வளர்க!" (may it grow!).',
    tamil_example: 'வாழ்க! (Long live! / May you/they live!) | வளர்க தமிழ்! (May Tamil flourish!) | செல்க! (May you go / go well!)',
    english_translation: 'Long live! | May Tamil flourish! | Go well! / May you go safely!'
  },
  {
    rule_text: 'Negative verb forms — இல்லை, இலன், இலள், இலர், இல, இல்ல.',
    explanation: 'Tamil negation in the finite verb uses negative forms: இல்லை (is/are not — general), இலன் (he is not / did not — classical masc.), இலள் (she is not — classical fem.), இலர் (they are not — rational pl.), இல / இல்ல (irrational). In modern Tamil the negative auxiliary இல்லை or the negative infinitive with the suffix -ஆ- are most common: "வரவில்லை" (did not come), "வர மாட்டான்" (he will not come).',
    tamil_example: 'அவன் வரவில்லை. (He did not come.) | நான் சாப்பிடவில்லை. (I did not eat.) | வராமல் போனான். (He went without coming.)',
    english_translation: 'He did not come. | I did not eat. | He went without coming.'
  },
  {
    rule_text: 'வினையெச்சம் (Adverbial participle) — verb form used to join clauses.',
    explanation: 'The வினையெச்சம் (adverbial participle) is formed by adding -உ to the past stem, giving a form meaning "having done X" or "doing X and then...". It connects two actions: the participle action happens first, then the main verb. This form is ubiquitous in Tamil — classical and modern — and once recognised, sentences open up dramatically.',
    tamil_example: 'வந்து சாப்பிட்டான். (Having come, he ate.) | படித்து தேர்ந்தான். (Having studied, he passed.) | பாடி ஆடினாள். (Having sung, she danced.)',
    english_translation: 'Having come, he ate. | Having studied, he passed. | Having sung, she danced.'
  }
].each do |r|
  GrammarRule.find_or_create_by!(rule_text: r[:rule_text], grammar_lesson: lesson20) do |gr|
    gr.assign_attributes(r)
  end
end

puts "  #{GrammarLesson.count} grammar lessons seeded"
puts "  #{GrammarRule.count} grammar rules seeded"

puts "\nDone! Database seeded successfully."
puts "  Letters: #{Letter.count}"
puts "  Words: #{Word.count}"
puts "  Grammar Lessons: #{GrammarLesson.count}"
puts "  Grammar Rules: #{GrammarRule.count}"
puts "  Reading Passages: #{ReadingPassage.count}"
puts "  Quiz Questions: #{QuizQuestion.count}"
puts "  Achievements: #{Achievement.count}"
