require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
  setup do
    @order = orders(:daves)
    I18n.locale = I18n.default_locale
  end

  teardown do
    I18n.locale = I18n.default_locale
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

  test "placing an order and selecting from dynamic dropdowns" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url
    add_first_item_to_cart

    click_on "Checkout"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"
    select 'Check', from: "Pay type"

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"
    fill_in 'Routing #', with: '123456789'
    fill_in 'Account #', with: '000987654321'

    assert_no_selector "#order_po_number"

    select "Purchase order", from: "Pay type"
    assert_selector "#order_po_number"
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    fill_in 'PO #', with: '433f3dae109'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"

    select 'Credit card', from: "Pay type"
    assert_no_selector "#order_po_number"
    fill_in 'CC #', with: '4444444444444444'
    fill_in 'Expiry', with: '08/17'

    perform_enqueued_jobs do
      click_on "Place Order"
    end

    assert_text "Thank you for your order"
    assert_text "Your Pragmatic Catalog"
    orders = Order.all
    assert_equal 1, orders.size
    order = orders.first
    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas", order.name
    assert_equal "123 Fake Street", order.address
    assert_equal "dave@wendys.example.com", order.email
    assert_equal "Credit card", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@wendys.example.com'],                 mail.to
    assert_equal 'Stateless Code <statelesscode@example.com>',       mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

  test "placing an order and selecting from dynamic dropdowns in Pirate" do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url(locale: 'pirate')
    add_first_item_to_cart
    click_on "Checkout! Arrr!"

    fill_in "Address or Ship", with: @order.address
    fill_in "E-mail", with: @order.email
    fill_in "Name", with: @order.name

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"
    select 'Check', from: "Pay type"

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"
    fill_in 'Routing #', with: '123456789'
    fill_in 'Account #', with: '000987654321'

    assert_no_selector "#order_po_number"

    select "IOU", from: "Pay type"
    assert_selector "#order_po_number"
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    fill_in 'IOU #', with: '433f3dae109'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"

    select 'Credit Card', from: "Pay type"
    assert_no_selector "#order_po_number"
    fill_in 'CC #', with: '4444444444444444'
    fill_in "Date it goes to Davy Jones' locker", with: '08/17'

    perform_enqueued_jobs do
      click_on "Get Loot"
    end

    assert_text "Thank ye for yer orrrder, matey"
    assert_text "Yer Pragmatic Catalog"
    orders = Order.all
    assert_equal 1, orders.size
    order = orders.first
    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas", order.name
    assert_equal "123 Fake Street", order.address
    assert_equal "dave@wendys.example.com", order.email
    assert_equal "Credit card", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['dave@wendys.example.com'],                 mail.to
    assert_equal 'Stateless Code <statelesscode@example.com>',       mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

  test "updating a Order" do
    skip
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
