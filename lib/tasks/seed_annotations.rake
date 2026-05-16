namespace :db do
  desc "Seed word-level annotations for reading passages"
  task seed_annotations: :environment do

    # ── Passage 1: My Family ─────────────────────────────────────────────────
    p1 = ReadingPassage.find_by(title: "My Family - என் குடும்பம்")
    if p1
      p1.update!(annotations: {
        "என்"            => { meaning: "my",                       role: "pronoun · genitive" },
        "பெயர்"          => { meaning: "name",                     role: "noun" },
        "முரளி"          => { meaning: "Murali (name)",            role: "proper noun" },
        "என்னுடைய"       => { meaning: "my",                       role: "pronoun · genitive (emphatic)" },
        "குடும்பத்தில்"  => { meaning: "in the family",            role: "noun + locative case (-இல்)" },
        "நான்கு"         => { meaning: "four",                     role: "number" },
        "பேர்"           => { meaning: "people",                   role: "noun" },
        "இருக்கிறோம்"    => { meaning: "we are / there are",       role: "verb · present · 1st person plural" },
        "அப்பா"          => { meaning: "father",                   role: "noun" },
        "ராஜன்"          => { meaning: "Rajan (name)",             role: "proper noun" },
        "அம்மா"          => { meaning: "mother",                   role: "noun" },
        "லக்ஷ்மி"        => { meaning: "Lakshmi (name)",           role: "proper noun" },
        "தங்கை"          => { meaning: "younger sister",           role: "noun" },
        "பிரியா"         => { meaning: "Priya (name)",             role: "proper noun" },
        "நாங்கள்"        => { meaning: "we (exclusive)",           role: "pronoun · 1st person plural" },
        "சென்னையில்"     => { meaning: "in Chennai",               role: "proper noun + locative (-இல்)" },
        "வாழ்கிறோம்"     => { meaning: "we live",                  role: "verb · present · 1st person plural" },
        "அலுவலகத்தில்"   => { meaning: "at the office",            role: "noun + locative case (-இல்)" },
        "வேலை"           => { meaning: "work / job",               role: "noun" },
        "செய்கிறார்"     => { meaning: "he/she does",              role: "verb · present · 3rd person honorific" },
        "ஆசிரியராக"      => { meaning: "as a teacher",             role: "noun + instrumental (-ஆக)" },
        "படிக்கிறாள்"    => { meaning: "she studies",              role: "verb · present · 3rd person feminine" },
        "நாம்"           => { meaning: "we (inclusive)",           role: "pronoun · 1st person plural inclusive" },
        "எல்லோரும்"      => { meaning: "everyone / all of us",     role: "pronoun · emphatic plural" },
        "சந்தோஷமாக"      => { meaning: "happily",                  role: "adverb" },
      })
      puts "✓ My Family annotated"
    end

    # ── Passage 2: The Market ────────────────────────────────────────────────
    p2 = ReadingPassage.find_by(title: "The Market - சந்தை")
    if p2
      p2.update!(annotations: {
        "அம்மாவுடன்"     => { meaning: "with mother",              role: "noun + sociative case (-உடன்)" },
        "சந்தைக்கு"      => { meaning: "to the market",            role: "noun + dative case (-க்கு)" },
        "போனேன்"         => { meaning: "I went",                   role: "verb · past · 1st person singular" },
        "சந்தையில்"      => { meaning: "in the market",            role: "noun + locative case (-இல்)" },
        "நிறைய"          => { meaning: "many / a lot",             role: "adverb" },
        "கடைகள்"         => { meaning: "shops",                    role: "noun · plural" },
        "இருந்தன"        => { meaning: "there were",               role: "verb · past · 3rd person plural (irrational)" },
        "காய்கறி"        => { meaning: "vegetables",               role: "noun" },
        "கடையில்"        => { meaning: "at the shop",              role: "noun + locative case (-இல்)" },
        "தக்காளி"        => { meaning: "tomato",                   role: "noun" },
        "வெங்காயம்"      => { meaning: "onion",                    role: "noun" },
        "கத்தரிக்காய்"   => { meaning: "brinjal / eggplant",       role: "noun" },
        "வாங்கினோம்"     => { meaning: "we bought",                role: "verb · past · 1st person plural" },
        "பழக்"           => { meaning: "fruit (oblique form)",     role: "noun · oblique" },
        "வாழைப்பழம்"     => { meaning: "banana",                   role: "noun" },
        "தண்ணீர்"        => { meaning: "water",                    role: "noun" },
        "குடித்தோம்"     => { meaning: "we drank",                 role: "verb · past · 1st person plural" },
        "வீட்டிற்கு"     => { meaning: "to the house",             role: "noun + dative case (-க்கு)" },
        "திரும்பி"       => { meaning: "having returned",          role: "verb · conjunctive participle" },
        "வந்தோம்"        => { meaning: "we came",                  role: "verb · past · 1st person plural" },
        "அம்மா"          => { meaning: "mother",                   role: "noun" },
        "விலை"           => { meaning: "price",                    role: "noun" },
        "கேட்டோம்"       => { meaning: "we asked",                 role: "verb · past · 1st person plural" },
      })
      puts "✓ The Market annotated"
    end

    # ── Passage 3: The Seasons ───────────────────────────────────────────────
    p3 = ReadingPassage.find_by(title: "The Seasons - பருவங்கள்")
    if p3
      p3.update!(annotations: {
        "தமிழ்"          => { meaning: "Tamil",                    role: "proper noun / adjective" },
        "நாட்டில்"       => { meaning: "in the country / land",    role: "noun + locative case (-இல்)" },
        "ஆறு"            => { meaning: "six",                      role: "number" },
        "பருவங்கள்"      => { meaning: "seasons",                  role: "noun · plural" },
        "உண்டு"          => { meaning: "there are / exist",        role: "verb · existential" },
        "இளவேனில்"       => { meaning: "spring (early summer)",    role: "noun · Tamil season 1" },
        "முதுவேனில்"     => { meaning: "late summer",              role: "noun · Tamil season 2" },
        "கார்"           => { meaning: "monsoon / rainy season",   role: "noun · Tamil season 3" },
        "குளிர்"         => { meaning: "winter / cold season",     role: "noun · Tamil season 4" },
        "முன்பனி"        => { meaning: "early dew season",         role: "noun · Tamil season 5" },
        "பின்பனி"        => { meaning: "late dew season",          role: "noun · Tamil season 6" },
        "என்று"          => { meaning: "thus / called",            role: "quotative particle" },
        "அழைக்கப்படும்"  => { meaning: "are called / known as",   role: "verb · passive · future/habitual" },
        "காலத்தில்"      => { meaning: "in the season / time",     role: "noun + locative case (-இல்)" },
        "மழை"            => { meaning: "rain",                     role: "noun" },
        "பெய்யும்"       => { meaning: "will rain / rains",        role: "verb · future / habitual" },
        "மலர்கள்"        => { meaning: "flowers",                  role: "noun · plural" },
        "பூக்கும்"       => { meaning: "will bloom / blooms",      role: "verb · future / habitual" },
        "குளிராக"        => { meaning: "coldly / with cold",       role: "adverb" },
        "இருக்கும்"      => { meaning: "will be / is",             role: "verb · future / habitual" },
        "வெப்பமாக"       => { meaning: "hotly / with heat",        role: "adverb" },
        "விவசாயிகள்"     => { meaning: "farmers",                  role: "noun · plural" },
        "நிலம்"          => { meaning: "land / soil",              role: "noun" },
        "உழுவார்கள்"     => { meaning: "they will plough",         role: "verb · future · 3rd person plural" },
      })
      puts "✓ The Seasons annotated"
    end

    # ── Passage 4: Thirukkural ───────────────────────────────────────────────
    p4 = ReadingPassage.find_by(title: "Thirukkural - திருக்குறள்")
    if p4
      p4.update!(annotations: {
        "அகர"            => { meaning: "of the letter அ",          role: "noun · genitive form" },
        "முதல"           => { meaning: "is the beginning / first", role: "predicate adjective" },
        "எழுத்தெல்லாம்"  => { meaning: "all letters",              role: "noun + emphatic (-எல்லாம்)" },
        "ஆதி"            => { meaning: "primordial / the origin",  role: "noun · Sanskrit loan" },
        "பகவன்"          => { meaning: "God / the divine being",   role: "noun" },
        "முதற்றே"        => { meaning: "has its beginning",        role: "verb · emphatic (-ஏ)" },
        "உலகு"           => { meaning: "the world",                role: "noun · classical form" },
        "கற்க"           => { meaning: "learn!",                   role: "verb · optative mood (வியங்கோள்)" },
        "கசடற"           => { meaning: "without flaw / perfectly", role: "adverb" },
        "கற்பவை"         => { meaning: "what is to be learned",    role: "noun · verbal noun (future participial)" },
        "கற்றபின்"       => { meaning: "after having learned",     role: "verb · perfective participle + postposition" },
        "நிற்க"          => { meaning: "stand firm!",              role: "verb · optative mood (வியங்கோள்)" },
        "அதற்குத்"       => { meaning: "for it / according to it", role: "pronoun + dative case (-க்கு)" },
        "தக"             => { meaning: "fittingly / worthily",     role: "adverb" },
        "யாதும்"         => { meaning: "whatever / every place",   role: "pronoun · emphatic (-உம்)" },
        "ஊரே"            => { meaning: "hometown / place",         role: "noun · emphatic (-ஏ)" },
        "யாவரும்"        => { meaning: "everyone / all people",    role: "pronoun · emphatic (-உம்)" },
        "கேளிர்"         => { meaning: "kin / dear ones",          role: "noun · classical Tamil" },
        "தீதும்"         => { meaning: "evil / harm",              role: "noun · emphatic (-உம்)" },
        "நன்றும்"        => { meaning: "goodness / good",          role: "noun · emphatic (-உம்)" },
        "பிறர்தர"        => { meaning: "given by others",          role: "verb · infinitive / gerundive" },
        "வாரா"           => { meaning: "do not come",              role: "verb · negative" },
      })
      puts "✓ Thirukkural annotated"
    end

    puts "\nDone."
  end
end
