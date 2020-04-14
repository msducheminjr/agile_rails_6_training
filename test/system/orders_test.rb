require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:daves)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "trying to create an Order with no cart redirects to the store" do
    visit orders_url
    click_on "New Order"

    assert_text "Your Pragmatic Catalog"
    assert_text "Your cart is empty"
  end

  test "creating a Order" do
    visit store_index_url
    add_first_item_to_cart
    click_on "Checkout"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select @order.pay_type, from: "Pay type"
    click_on "Place Order"

    assert_text "Thank you for your order."
    assert_text "Your Pragmatic Catalog"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    select "Purchase order", from: "Pay type"
    click_on "Place Order"

    assert_text "Order was successfully updated"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
