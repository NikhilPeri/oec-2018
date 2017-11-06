require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/test_unit'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :exchanges
  fixtures :admins
  fixtures :brokers
  fixtures :stocks
  fixtures :holdings

  # Add more helper methods to be used by all tests here...
end
