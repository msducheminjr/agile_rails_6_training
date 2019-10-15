require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @line_item = line_items(:one)
    @line_item_rendered = render(@line_item)
    @cart = carts(:two)
    @cart_rendered = render(@cart)
  end

  test "render_if renders expected partial for object if condition is met" do
    expectations = [
      [@line_item, 3==3, @line_item_rendered],
      [@cart, @cart.line_items.any?, @cart_rendered]
    ]

    expectations.each do |el|
      assert_equal el[2], render_if(el[1], el[0]), "Expected render_if for item to equal #{el[2]}"
    end

  end

  test "render_if returns nil if condition not met" do
    expectations = [
      [@line_item, 3==2],
      [@cart, @cart.line_items.length > 400]
    ]

    expectations.each do |el|
      assert_nil render_if(el[1], el[0]), "Expected render_if to be nil for #{el[0].inspect}"
    end
  end

end
