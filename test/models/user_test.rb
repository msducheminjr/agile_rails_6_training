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

  test 'cannot destroy last user' do
    failed_delete = assert_raises User::Error do
      User.destroy_all
    end

    assert_equal "Can't delete last user", failed_delete.message
  end
end
