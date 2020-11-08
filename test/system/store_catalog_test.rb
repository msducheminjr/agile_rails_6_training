require "application_system_test_case"

class StoreCatalogTest < ApplicationSystemTestCase
  setup do
    @product = products(:ruby)
    I18n.locale = I18n.default_locale
  end

  teardown do
    I18n.locale = I18n.default_locale
  end

  test "visiting the index and switching locales" do
    visit '/'
    assert_selector "h1", text: "Your Pragmatic Catalog"
    assert_selector "ul.catalog li h2", text: @product.title
    select 'Pirate', from: "set_locale"
    assert_selector "h1", text: "Yer Pragmatic Catalog"
    select 'Español', from: "set_locale"
    assert_selector "h1", text: "Su Catálogo de Pragmatic"
    select 'English', from: "set_locale"
    assert_selector "h1", text: "Your Pragmatic Catalog"
  end

  test "adding an item to the cart" do
    visit '/'
    add_first_item_to_cart
    assert_selector "h2", text: "Your Cart"
    assert_text "#{Product.order(:title).first.title}"
    assert_selector "tr.line-item-highlight td", text: "#{Product.order(:title).first.title}"
  end
end
