require "application_system_test_case"

class StoreCatalogTest < ApplicationSystemTestCase
  setup do
    @product = products(:ruby)
  end

  test "visiting the index" do
    visit '/'
    assert_selector "h1", text: "Your Pragmatic Catalog"
    assert_selector "ul.catalog li h2", text: @product.title
  end

  test "adding an item to the cart" do
    visit '/'
    #TODO make this better
    find(:xpath, '/html/body/section/main/ul/li[1]/div/form/input[1]').click
    assert_selector "h2", text: "Your Cart"
    assert_text "#{Product.order(:title).first.title}"
  end
end
