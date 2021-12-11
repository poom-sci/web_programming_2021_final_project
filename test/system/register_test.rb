require "application_system_test_case"

class RegistersTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)

  end

  test "cccc register success" do
    visit register_url
    fill_in "Email", with: 'cccc@gmail.com'
    fill_in "Display name", with: 'cccc'
    fill_in "Password", with: '123456789'
    fill_in "Password confirmation", with: '123456789'
    click_on "Create User"
    assert_text "User was successfully created."
  end

  test "dddd register success" do
    visit register_url
    fill_in "Email", with: 'dddd@gmail.com'
    fill_in "Display name", with: 'dddd'
    fill_in "Password", with: '123456789'
    fill_in "Password confirmation", with: '123456789'
    click_on "Create User"
    assert_text "User was successfully created."
  end

  test "cccc register email blank" do
    visit register_url
    fill_in "Display name", with: 'cccc'
    fill_in "Password", with: '123456789'
    click_on "Create User"
    assert_text "Email can't be blank"
  end

  test "cccc Display email blank and less than 4 char" do
    visit register_url
    fill_in "Email", with: 'cccc@gmail.com'
    fill_in "Password", with: '123456789'
    click_on "Create User"
    assert_text "Display name can't be blank and Display name is too short (minimum is 4 characters)"
  end

    test "email is already used" do
    visit register_url
    fill_in "Email", with: 'aaaa@gmail.com'
    fill_in "Display name", with: 'aaaa'
    fill_in "Password", with: '123456789'
    click_on "Create User"
    assert_text "Email has already been taken"
  end

end