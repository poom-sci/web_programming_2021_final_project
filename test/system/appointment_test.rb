require "application_system_test_case"

class AppointmentTest < ApplicationSystemTestCase
  setup do
    @u1 = users(:usera)

  end

  test "u1 appoint restaurant1 success" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '1'
    select "1", from: "Table number"
    select "10:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "Appointment at restaurant1 was successfully created."
  end

  test "u1 appoint restaurant1 success and show appointment" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '1'
    select "1", from: "Table number"
    select "10:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "restaurant1"
    assert_text "table number: 1"
    assert_text "10:00:00"
  end

  test "u1 appoint restaurant1 failed with already reserved" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '1'
    select "1", from: "Table number"
    select "20:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end
    visit '/restaurant_list'
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '1'
    select "1", from: "Table number"
    select "20:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end



    assert_text "The table 1 is already reserved."
  end

  test "u1 appoint restaurant1 failed with overlimit amount of table capacity" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '100'
    select "1", from: "Table number"
    select "10:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "The capacity of table1 is not more than 4"
  end


  test "u1 remove restaurant1 appointment" do
    visit login_url
    fill_in "Email", with: @u1.email
    fill_in "Password", with: 'aaaa'
    click_on "Login"
    find('a', text:"Restaurant List").click
    first('a', text:"Go").click
    first('a', text:"Appoint").click
    fill_in "People amount", with: '1'
    select "1", from: "Table number"
    select "10:00", from: "Time start"
    page.accept_confirm do
      click_on "Confirm"
    end
    first('a', text:"cancel").click

    assert_text "Remove restaurant1 " + Date.today.to_s + " 10:00:00 +0700 from appointment list successfully."
  end




end