require 'test_helper'

class SimulateJobTest < ActiveSupport::TestCase
  setup do
    @exchange = exchanges(:one)
  end

  test "SimulateJob does not execute if exchange is not live" do
    @exchange.pause
    SimulateJob.perform(@exchange)

    assert_equal current_day, @exchange.day
  end

  test "SimulateJob steps day if exchange is live" do
    @exchange.start
    SimulateJob.perform(@exchange)

    assert_equal current_day + 1, @exchange.day
  end
end
