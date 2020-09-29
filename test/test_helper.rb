ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def run_model_fixture_tests(klass_name)
    klass_name.all.each do |model_record|
      assert(model_record.valid?, "Invalid #{klass_name} Fixture: #{model_record.inspect}\n\nErrors: #{model_record.errors.messages}")
    end
  end
end

module AuthenticationHelpers
  def login_as(user)
    if respond_to? :visit
      visit login_url
      fill_in :name, with: user.name
      fill_in :password, with: 'secret'
      click_on 'Login'
    else
      post login_url, params: { name: user.name, password: 'secret' }
    end
  end

  def logout
    delete logout_url
  end

  def setup
    login_as users(:merry)
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelpers
end

class ActionDispatch::SystemTestCase
  include AuthenticationHelpers
end