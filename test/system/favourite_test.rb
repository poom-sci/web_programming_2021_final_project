require "application_system_test_case"

class FavouritesTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)
    @restaurant1 = restaurants(:restaurant1)
    @favourite2 = favourites(:two)
  end

  test "u1 add restaurant1 to favourite success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Add to favourite").click
    assert_text "Restaurant was successfully added to favourite."
  end

  test "restaurant1 show on restaurant list of u1" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Add to favourite").click
    visit 'restaurant_list'
    assert_text "restaurant1"
  end

  test "remove restaurant2 from u1" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Favourite").click
    
    page.accept_confirm do
      first('a', text:"Remove").click
    end
    assert_text "Remove restaurant2 from favourite list successfully."
  end


end