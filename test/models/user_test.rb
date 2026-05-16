require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creates user_progress after create" do
    user = User.create!(name: "Test", email: "test_#{SecureRandom.hex(4)}@example.com",
                        password: "password123", level: "beginner")
    assert_not_nil user.user_progress
  end

  test "has many letters through user_letters" do
    user = users(:vino)
    assert_includes user.letters, letters(:vowel_a)
  end

  test "has many achievements through user_achievements" do
    user = users(:vino)
    assert_includes user.achievements, achievements(:first_letter)
  end

  test "LEVELS constant covers expected values" do
    assert_includes User::LEVELS, "beginner"
    assert_includes User::LEVELS, "intermediate"
    assert_includes User::LEVELS, "advanced"
  end
end
