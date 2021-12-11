require "application_system_test_case"

class CommentTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)
    @favourite2 = favourites(:two)

  end

  test "u1 rate restaurant1 success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Comment").click
    fill_in "Msg", with: 'This is a test comment'
    page.accept_confirm do
      click_on "Submit"
    end

    assert_text "Comment to restaurant1 was successfully created."
  end

  test "restaurant1 show rate of 4 in restaurant list of u1" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Comment").click
    fill_in "Msg", with: 'This is a test comment'
    page.accept_confirm do
      click_on "Submit"
    end
    visit 'restaurant_list'
    first('a', text:"Go").click
    assert_text "This is a test comment"
  end

  test "u1 edit rate" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Comment").click
    fill_in "Msg", with: 'This is a test comment'
    page.accept_confirm do
      click_on "Submit"
    end
    visit 'restaurant_list'
    first('a', text:"Go").click
    first('a', text:"Edit Comment").click
    fill_in "Msg", with: 'This is a edit test comment'
    page.accept_confirm do
      click_on "Submit"
    end
    assert_text "Comment was successfully edited."
  end


end