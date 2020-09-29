require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has valid fixtures" do
    run_model_fixture_tests User
  end

  test 'validates uniqueness of name' do
    user = User.first
    dupe = User.new(name: user.name)
    assert dupe.invalid?
    assert_equal ["has already been taken"], dupe.errors[:name]
  end
end
