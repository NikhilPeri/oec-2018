module ChaosAgent
  module Buyer < Base
    def perform(exchange)
      bought_stocks = Transactions.where(day: exchange.day, action: 'buy').stocks
      bought_stocks.each do |stock|
        stock.update(intermediate_vec: stock.intermediate_vec * 1.15)
      end
    end
  end
end
