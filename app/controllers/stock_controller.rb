class StockController < ApplicationController
  before_action :authenticate_broker, only: %w(query_single, query_multi)

  def show
    @stock = Stock.find_by(ticker: params[:ticker])
    render_404 unless @stock
  end

  def query_single
    @stock = Stock.find_by(ticker: params[:ticker])

    start_day = query_start_day || 0
    stop_day = query_stop_day || @stock.historical_price.count
    historical_price = @stock.historical_price.from(start_day).to(stop_day)

    render json: { ticker: @stock.ticker, price: @stock.price, historical_price: historical_price}
  end

  def query_start_day
    params[:start].to_i if params[:start]&.to_i&.positive?
  end

  def query_stop_day
    params[:stop].to_i if params[:stop]&.to_i&.positive?
  end

  def query_tickers
    params[:tickers].to(25)
  end
end
