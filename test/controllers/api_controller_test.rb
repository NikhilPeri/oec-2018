require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  setup do
    @broker = brokers(:one)
  end

  test "#stock returns stock price when stock exists" do
    stock = stocks(:one)
    params = { key: @broker.token, ticker: stock.ticker }
    expected_response = {
      'success'=> true,
      'errors'=> [],
      'ticker'=> stock.ticker,
      'price'=> stock.price,
      'historical_price'=> stock.historical_price[0..10],
    }

    get :stock_quote, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#stock returns InvalidStockTicker when stock does not exist" do
    params = { key: @broker.token, ticker: 'BUTTS' }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidStockTicker'],
    }

    get :stock_quote, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#stock returns InvalidAPIKey when broker key not valid" do
    stock = stocks(:one)
    params = { key: 'lol-this-is-not-a-legit-key', ticker: stock.ticker }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidAPIKey'],
    }

    get :stock_quote, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#buy calls buy on broker" do
    stock = stocks(:one)
    params = { key: @broker.token, ticker: stock.ticker, shares: 100 }
    expected_response = {
      'success'=> true,
      'errors'=> [],
      'ticker'=> stock.ticker
    }

    @broker.expects(:buy).with(stock, 100)

    get :buy, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#buy returns InvalidStockTicker when stock does not exist" do
    params = { key: @broker.token, ticker: 'BUTTS', shares: 100 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidStockTicker'],
    }

    get :buy, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#buy returns InsufficientFunds when broker is actually broke" do
    stock = stocks(:one)
    max_shares = @broker.cash / stock.price
    params = { key: @broker.token, ticker: stock.ticker, shares: max_shares.to_i + 2 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InsufficientFunds'],
    }

    get :buy, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#buy returns InvalidAPIKey when broker key not valid" do
    stock = stocks(:one)
    params = { key: 'lol-this-is-not-a-legit-key', ticker: stock.ticker, shares: 100 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidAPIKey'],
    }

    get :buy, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#sell calls sell on broker" do
    stock = stocks(:one)
    @broker.buy(stock, 100)
    params = { key: @broker.token, ticker: stock.ticker, shares: 100 }
    expected_response = {
      'success'=> true,
      'errors'=> [],
      'ticker'=> stock.ticker
    }

    @broker.expects(:sell).with(stock, 100)

    get :sell, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#sell returns InvalidStockTicker when stock does not exist" do
    params = { key: @broker.token, ticker: 'BUTTS', shares: 100 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidStockTicker'],
    }

    get :sell, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#sell returns InsufficientShares when broker does not have sufficient shares in stock" do
    stock = stocks(:one)
    params = { key: @broker.token, ticker: stock.ticker, shares: 1000 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InsufficientShares'],
    }

    get :sell, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#sell returns InvalidAPIKey when broker key not valid" do
    stock = stocks(:one)
    params = { key: 'lol-this-is-not-a-legit-key', ticker: stock.ticker, shares: 100 }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidAPIKey'],
    }

    get :sell, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#account returns correct json" do
    stock = stocks(:one)
    @broker.buy(stock, 100)
    holding = @broker.holdings.find_by(stock: stock)
    params = { key: @broker.token }
    expected_response = {
      'success'=> true,
      'errors'=> [],
      'cash'=> 100000000,
      'holdings'=> [
        {
          'ticker'=> stock.ticker,
          'shares'=> 100,
          'book_cost'=> holding.book_cost,
          'market_value'=> holding.market_value,
        },
      ]
    }

    get :account, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end

  test "#account returns InvalidAPIKey when broker key not valid" do
    params = { key: 'lol-this-is-not-a-legit-key' }
    expected_response = {
      'success'=> false,
      'errors'=> ['InvalidAPIKey'],
    }

    get :account, params: params

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end
end
