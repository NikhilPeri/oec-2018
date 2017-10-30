require 'test_helper'

class StockTest < ActiveSupport::TestCase

  setup do
    @exchange = exchanges(:one)
  end

  test "initialize populates all variables except exchange when not specified" do
    stock = Stock.new

    assert_nil stock.exchange

    refute_nil stock.ticker
    refute_nil stock.price
    refute_nil stock.annual_vec
    refute_nil stock.intermediate_vec
    refute_nil stock.daily_vec
  end

  test "save fails if ticker taken" do
    stock1 = Stock.new(exchange: @exchange)
    assert stock1.save

    stock2 = Stock.new(ticker: stock1.ticker, exchange: @exchange)

    assert_equal stock1.ticker, stock2.ticker
    refute stock2.save
  end

  test "update_price applies daily_vec price change" do
    initial_price = 1000
    vec = 0.01
    stock = Stock.new(price: 1000, annual_vec: vec, intermediate_vec: vec, daily_vec: vec)

    stock.update_price

    assert_equal initial_price*(1+vec), stock.price
  end

  test "historical_price tracks previous price changes" do
    initial_price = 1000
    vec = 0.01
    stock = Stock.new(price: initial_price, annual_vec: vec, intermediate_vec: vec, daily_vec: vec)
    new_price = (initial_price*(1+vec)).round

    stock.update_price

    assert_equal [new_price, initial_price], stock.historical_price
  end
end
