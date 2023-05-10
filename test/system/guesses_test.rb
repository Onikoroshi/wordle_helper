require "application_system_test_case"

class GuessesTest < ApplicationSystemTestCase
  setup do
    @guess = guesses(:one)
  end

  test "visiting the index" do
    visit guesses_url
    assert_selector "h1", text: "Guesses"
  end

  test "creating a Guess" do
    visit guesses_url
    click_on "New Guess"

    click_on "Create Guess"

    assert_text "Guess was successfully created"
    click_on "Back"
  end

  test "updating a Guess" do
    visit guesses_url
    click_on "Edit", match: :first

    click_on "Update Guess"

    assert_text "Guess was successfully updated"
    click_on "Back"
  end

  test "destroying a Guess" do
    visit guesses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guess was successfully destroyed"
  end
end
