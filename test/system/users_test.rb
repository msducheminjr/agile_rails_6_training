require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:merry)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    username = 'newuser'

    fill_in "Name", with: username
    fill_in "Password", with: 'secret'
    fill_in "Confirm", with: 'secret'
    click_on "Create User"

    assert_text "User #{username} was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Name", with: @user.name
    fill_in "Password", with: 'moresecret'
    fill_in "Confirm", with: 'moresecret'
    click_on "Update User"

    assert_text "User #{@user.name} was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    # log in as Pippin because Merry will be destroyed
    login_as users(:pippin)
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
