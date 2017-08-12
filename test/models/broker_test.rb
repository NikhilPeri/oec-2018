require 'test_helper'

class BrokerTest < ActiveSupport::TestCase
  setup do
      @broker = Broker.find(1)
      @stock = Stock.find(1)
  end

  test "buy adds a holding to the brokers portfolio" do
    @broker.buy(@stock, 100)
    created_holding =  @broker.holdings.find_by(stock: @stock)

    assert_equal @stock, created_holding.stock
    assert_equal 100, created_holding.shares
    assert_equal @broker, created_holding.broker
  end

  test "buy on existing holding updates the shares and book cost" do
    expected_book_cost = 100 * @stock.price
    @broker.buy(@stock, 100)
    
    @stock.price *= 2
    @stock.save
    expected_book_cost += 100 * @stock.price
    @broker.buy(@stock, 100)

    created_holding =  @broker.holdings.find_by(stock: @stock)

    assert_equal 200, created_holding.shares
    assert_equal expected_book_cost, created_holding.book_cost
  end

  test "buy withdraws specified amount of cash from brokers account" do
    assert_empty @broker.holdings
    expected_cash = @broker.cash - @stock.price*100
    @broker.buy(@stock, 100)

    assert_equal expected_cash, @broker.cash
  end

  test "withdraw raises expection if inssufficient funds" do
    @broker.cash = 0
    assert_raise InsufficientFundsError do
      @broker.withdraw_cash(100)
    end
  end
end
