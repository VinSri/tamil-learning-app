require "test_helper"

class LetterTest < ActiveSupport::TestCase
  # Validations
  test "valid letter is valid" do
    letter = Letter.new(tamil: "உ", roman: "u", kind: "vowel", position: 3)
    assert letter.valid?
  end

  test "requires tamil" do
    letter = Letter.new(roman: "a", kind: "vowel", position: 99)
    assert_not letter.valid?
    assert_includes letter.errors[:tamil], "can't be blank"
  end

  test "requires roman" do
    letter = Letter.new(tamil: "உ", kind: "vowel", position: 99)
    assert_not letter.valid?
    assert_includes letter.errors[:roman], "can't be blank"
  end

  test "rejects invalid kind" do
    letter = Letter.new(tamil: "உ", roman: "u", kind: "unknown", position: 99)
    assert_not letter.valid?
  end

  test "tamil must be unique" do
    letter = Letter.new(tamil: letters(:vowel_a).tamil, roman: "a", kind: "vowel", position: 99)
    assert_not letter.valid?
    assert_includes letter.errors[:tamil], "has already been taken"
  end

  # Scopes
  test "vowels scope returns only vowels ordered by position" do
    vowels = Letter.vowels
    assert vowels.all? { |l| l.kind == "vowel" }
    assert_equal vowels.sort_by(&:position), vowels.to_a
  end

  test "consonants scope returns only consonants" do
    consonants = Letter.consonants
    assert consonants.all? { |l| l.kind == "consonant" }
  end

  # Associations
  test "has many users through user_letters" do
    letter = letters(:vowel_a)
    assert_includes letter.users, users(:vino)
  end
end
