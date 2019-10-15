require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox , screen_size: [1400, 1400]

  def add_first_item_to_cart
    #TODO make this better
    find(:xpath, '/html/body/section/main/ul/li[1]/div/form/input[1]').click
  end

end
