require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "span", count: 10
  end

  test "saying Hello yields a grumpy response from the coach" do
    visit new_url
    fill_in "answer", with: "Bonjour"
    click_on "Play"

    assert_text "Sorry but"
  end
end
