require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "creating a Cart" do
    visit carts_url
    click_on "New Cart"

    click_on "Create Cart"

    assert_text "Cart was successfully created"
  end

  test "updating a Cart" do
    visit carts_url
    click_on "Edit", match: :first

    click_on "Update Cart"

    assert_text "Cart was successfully updated"
  end

  test "destroying a Cart from carts page" do
    visit store_index_url

    find(:xpath, '/html/body/section/main/ul/li[1]/div/form/input[1]').click

    page.accept_confirm do
      within('main') do
        click_on "Empty cart"
      end
    end

    assert_text 'Your cart is currently empty'
    assert_text 'Your Pragmatic Catalog'
  end

  test "destroying a Cart from store page" do
    visit store_index_url

    page.accept_confirm do
      click_on "Empty cart"
    end

    assert_text 'Your cart is currently empty'
    assert_text 'Your Pragmatic Catalog'
  end

  test "visiting a valid cart" do
    visit cart_url(@cart)
    assert_text "Your Cart"
  end

  test "visiting cart_url with invalid id" do
    visit cart_url('wibble')
    assert_text "Invalid cart"
    assert_selector "h1", text: "Your Pragmatic Catalog"
  end
end
