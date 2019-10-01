require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "has valid fixtures" do
    run_model_fixture_tests LineItem
  end

  test "total_price returns quantity times product price" do
    assert_equal 9.99, line_items(:one).total_price
    assert_equal 19.98, line_items(:two).total_price
  end
end
