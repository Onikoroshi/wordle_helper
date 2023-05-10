require "test_helper"

class IgnoredWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ignored_word = ignored_words(:one)
  end

  test "should get index" do
    get ignored_words_url
    assert_response :success
  end

  test "should get new" do
    get new_ignored_word_url
    assert_response :success
  end

  test "should create ignored_word" do
    assert_difference('IgnoredWord.count') do
      post ignored_words_url, params: { ignored_word: {  } }
    end

    assert_redirected_to ignored_word_url(IgnoredWord.last)
  end

  test "should show ignored_word" do
    get ignored_word_url(@ignored_word)
    assert_response :success
  end

  test "should get edit" do
    get edit_ignored_word_url(@ignored_word)
    assert_response :success
  end

  test "should update ignored_word" do
    patch ignored_word_url(@ignored_word), params: { ignored_word: {  } }
    assert_redirected_to ignored_word_url(@ignored_word)
  end

  test "should destroy ignored_word" do
    assert_difference('IgnoredWord.count', -1) do
      delete ignored_word_url(@ignored_word)
    end

    assert_redirected_to ignored_words_url
  end
end
