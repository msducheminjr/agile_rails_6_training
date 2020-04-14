require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:daves)
  end

  test "has valid fixtures" do
    run_model_fixture_tests Order
  end

  test "invalid if missing name, address, or email" do
    attribs = [:name, :address, :email]
    blanks = [nil, '']
    attribs.each do |attrib|
      blanks.each do |blank|
        @order.write_attribute(attrib, blank)
        assert @order.invalid?
        assert_includes @order.errors[attrib], "can't be blank",
          "Expected error message to be 'can't be blank'"
      end
    end
  end

  test "raises argument error if bogus pay type" do
    failed_bribe = assert_raises ArgumentError do
      @order.pay_type = 'Bribe'
    end
    assert_equal "'Bribe' is not a valid pay_type", failed_bribe.message
  end
end
