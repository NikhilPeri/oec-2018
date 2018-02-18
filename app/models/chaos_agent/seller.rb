module ChaosAgent
  module Seller < Base
    def perform(exchange)
      bought_stocks = Transactions.where(day: exchange.day, action: 'sell').stocks
      bought_stocks.each do |stock|
        stock.update(intermediate_vec: stock.intermediate_vec * 0.75)
      end
    end
  end
end
