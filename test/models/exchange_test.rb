require 'test_helper'

class ExchangeTest < ActiveSupport::TestCase
  setup do
    @exchange = Exchange.find(1)
  end

  test "step_time does not execute if exchange is not live" do
    @exchange.pause
    current_day = @exchange.day
    @exchange.step_time

    assert_equal current_day, @exchange.day
  end

  test "step_time steps day if exchange is live" do
    @exchange.start
    current_day = @exchange.day
    @exchange.step_time

    assert_equal current_day + 1, @exchange.day
  end
end
