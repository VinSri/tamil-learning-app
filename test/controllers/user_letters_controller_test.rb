require "test_helper"

class UserLettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user   = users(:vino)
    @letter = letters(:consonant_ka)
  end

  test "requires authentication" do
    post user_letters_path, params: { letter_id: @letter.id }, as: :json
    assert_response :unauthorized
  end

  test "marks a letter as learned" do
    sign_in @user
    assert_difference "@user.letters.count", 1 do
      post user_letters_path, params: { letter_id: @letter.id }, as: :json
    end
    assert_response :success
    json = response.parsed_body
    assert_equal true, json["learned"]
  end

  test "unmarks a letter already learned" do
    sign_in @user
    # vowel_a is already learned in fixtures
    assert_difference "@user.letters.count", -1 do
      post user_letters_path, params: { letter_id: letters(:vowel_a).id }, as: :json
    end
    json = response.parsed_body
    assert_equal false, json["learned"]
  end

  test "returns updated total count" do
    sign_in @user
    post user_letters_path, params: { letter_id: @letter.id }, as: :json
    json = response.parsed_body
    assert_equal @user.letters.count, json["total"]
  end
end
