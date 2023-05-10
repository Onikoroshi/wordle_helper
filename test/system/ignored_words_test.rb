require "application_system_test_case"

class IgnoredWordsTest < ApplicationSystemTestCase
  setup do
    @ignored_word = ignored_words(:one)
  end

  test "visiting the index" do
    visit ignored_words_url
    assert_selector "h1", text: "Ignored Words"
  end

  test "creating a Ignored word" do
    visit ignored_words_url
    click_on "New Ignored Word"

    click_on "Create Ignored word"

    assert_text "Ignored word was successfully created"
    click_on "Back"
  end

  test "updating a Ignored word" do
    visit ignored_words_url
    click_on "Edit", match: :first

    click_on "Update Ignored word"

    assert_text "Ignored word was successfully updated"
    click_on "Back"
  end

  test "destroying a Ignored word" do
    visit ignored_words_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ignored word was successfully destroyed"
  end
end
