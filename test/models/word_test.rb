require "test_helper"

class WordTest < ActiveSupport::TestCase
  test "valid word is valid" do
    word = Word.new(tamil: "அம்மா", english: "Mother", category: "family")
    assert word.valid?
  end

  test "requires tamil" do
    word = Word.new(english: "Hello", category: "basics")
    assert_not word.valid?
    assert_includes word.errors[:tamil], "can't be blank"
  end

  test "requires english" do
    word = Word.new(tamil: "அம்மா", category: "family")
    assert_not word.valid?
    assert_includes word.errors[:english], "can't be blank"
  end

  test "rejects invalid category" do
    word = Word.new(tamil: "அம்மா", english: "Mother", category: "unknown")
    assert_not word.valid?
  end

  test "by_category scope filters correctly" do
    basics = Word.by_category("basics")
    assert basics.all? { |w| w.category == "basics" }
  end

  test "by_category scope orders by english" do
    basics = Word.by_category("basics")
    assert_equal basics.sort_by(&:english), basics.to_a
  end
end
