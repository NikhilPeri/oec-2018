class StockController < ApplicationController
  def show
    @stock = Stock.where(exchange_id: params[:exchange_id], ticker: params[:ticker])
  end
end
