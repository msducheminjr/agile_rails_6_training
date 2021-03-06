require "application_system_test_case"

class LineItemsTest < ApplicationSystemTestCase
  setup do
    @line_item = line_items(:one)
  end

  test "visiting the index" do
    visit line_items_url
    assert_selector "h1", text: "Line Items"
  end

  test "updating a Line item" do
    visit line_item_url(@line_item)
    click_on "Edit", match: :first

    fill_in "Product", with: @line_item.product_id
    click_on "Update Line item"

    assert_text "Line item was successfully updated"
    assert_text "Your Cart"
  end

  test "destroying a Line item" do
    visit line_item_url(@line_item)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Line item was successfully destroyed"
    assert_text "Your Cart"
  end
end
