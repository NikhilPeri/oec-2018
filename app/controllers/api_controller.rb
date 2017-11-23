class ApiController < ApplicationController
  before_action :fetch_broker

  # all fees in cents
  QUOTE_FEE = 500
  BUY_FEE = 1000
  ACCOUNT_FEE = 2000

  def stock_list
    if result[:success]
      result.merge!({
        stock_tickers: Stock.all.map{ |s| s.ticker }
      })
    end

    render json: result
  end

  def stock_quote
    #withdraw_cash(QUOTE_FEE)
    stock = fetch_stock(params[:ticker])
    if result[:success]
      result.merge!({
        ticker: stock.ticker,
        price: stock.price,
        historical_price: stock.historical_price,
      })
    end

    render json: result
  end

  def buy
    withdraw_cash(BUY_FEE)
    stock = fetch_stock(params[:ticker])
    if result[:success]
      begin
        @broker.buy(stock, params[:shares].to_i)
        result.merge!({
          ticker: stock.ticker,
        })
      rescue Broker::InsufficientFundsError
        result[:success] = false
        result[:errors] << 'InsufficientFunds'
      end
    end

    render json: result
  end

  def sell
    withdraw_cash(BUY_FEE)
    stock = fetch_stock(params[:ticker])
    if result[:success]
      begin
        @broker.sell(stock, params[:shares].to_i)
        result.merge!({
          ticker: stock.ticker,
        })
      rescue Broker::InsufficientSharesError
        result[:success] = false
        result[:errors] << 'InsufficientShares'
      end
    end

    render json: result
  end

  def account
    if result[:success]
      holdings = @broker.holdings.map do |holding|
        {
          ticker: holding.stock.ticker,
          shares: holding.shares,
          book_cost: holding.book_cost,
          market_value: holding.market_value
        }
      end

      result.merge!({
          cash: @broker.cash,
          holdings: holdings,
      })
    end

    render json: result
  end

  private

  def fetch_broker
    @broker = Broker.find_by(token: params[:key])
    unless @broker
      result[:success] = false
      result[:errors] << 'InvalidAPIKey'
    end
  end

  def fetch_stock(ticker)
    stock = Stock.find_by(ticker: ticker)
    if stock.present?
      stock
    else
      result[:success] = false
      result[:errors] << 'InvalidStockTicker'
    end
  end

  def withdraw_cash(amount)
    @broker&.withdraw_cash(QUOTE_FEE)
  rescue Broker::InsufficientFundsError
    result[:success] = false
    result[:errorss] << 'InsufficientFunds'
  end

  def result
    @result ||= {
      success: true,
      errors: [],
    }
  end
end
