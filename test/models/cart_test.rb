require 'test_helper'

class CartTest < ActiveSupport::TestCase

  setup do
    @cart = carts(:two)
  end

  test "has valid fixtures" do
    run_model_fixture_tests Cart
  end

  test "add_product builds new product line item if it doesn't exist in cart" do
    line_item = @cart.add_product(products(:ruby))
    assert line_item.valid?, 'Expected line item to be valid'
    assert line_item.save, 'Expected to save line item'
    assert_equal products(:ruby), line_item.reload.product
    assert_equal @cart, line_item.cart
    assert_equal 1, line_item.quantity
  end

  test "add_product increments product line item quantity if it doesn't exist in cart" do
    line_item = @cart.add_product(products(:two))
    assert_equal 3, line_item.quantity
    assert line_item.valid?, 'Expected line item to be valid'
    assert line_item.save, 'Expected to save line item'
    assert_equal products(:two), line_item.reload.product
    assert_equal @cart, line_item.cart
    assert_equal 3, line_item.quantity
  end

  test 'total price returns total price of all line items in cart' do
    assert_equal 19.98, @cart.total_price
    cart = carts(:one)
    assert_equal 9.99, cart.total_price
    6.times do
      item = cart.reload.add_product(products(:ruby))
      item.save!
      item = cart.reload.add_product(products(:one))
      item.save!
    end
    assert_equal 366.93, cart.reload.total_price
  end

end
