require "application_system_test_case"

class EditsNameTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)
    @u2 = users(:userb)
  end

  test "u1 change name success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    click_on "edit profile"
    fill_in "Display name", with: 'aaaa2'
    click_on "Edit"
    assert_text "User was successfully updated name to aaaa2 ."
  end

  test "u1 change name cannot be the same" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    click_on "edit profile"
    fill_in "Display name", with: 'aaaa'
    click_on "Edit"
    assert_text "The new display name can't be the same."
  end

  test "u1 change name cannot be blank" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    click_on "edit profile"
    fill_in "Display name", with: ''
    click_on "Edit"
    assert_text "The new display name can't be blank."
  end

  test "u2 change name to be same as u1" do
    visit login_url
    fill_in "Email", with: @u2.email
    fill_in "Password", with: 'bbbb'
    click_on "Login"
    click_on "edit profile"
    fill_in "Display name", with: 'aaaa'
    click_on "Edit"
    assert_text "The name aaaa is already used."
  end

end