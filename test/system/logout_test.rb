require "application_system_test_case"

class LogoutsTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)
    @u2 = users(:userb)
  end

  test "u1 logout success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    first('a', text:"Logout").click
    assert_text "User logout successfully."
  end




end