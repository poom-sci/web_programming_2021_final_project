require "application_system_test_case"

class RateTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)
    @favourite2 = favourites(:two)
    @rate = rates(:two)
  end

  test "u1 rate restaurant1 success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Rate").click
    select "1", from: "Rate score"
    page.accept_confirm do
      click_on "Submit"
    end

    assert_text "Rate to restaurant1 was successfully created."
  end

  test "restaurant1 show rate of 4 in restaurant list of u1" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Rate").click
    select "4", from: "Rate score"
    page.accept_confirm do
      click_on "Submit"
    end
    visit 'restaurant_list'
    assert_text "4.0"
  end

  test "u1 edit rate" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Rate").click
    select "4", from: "Rate score"
    page.accept_confirm do
      click_on "Submit"
    end

    visit '/restaurant_list'
    first('a', text:"Go").click
    first('a', text:"Edit Rate").click
    select "3", from: "Rate score"
    page.accept_confirm do
      click_on "Submit"
    end
    assert_text "Rate was successfully updated."
  end


end