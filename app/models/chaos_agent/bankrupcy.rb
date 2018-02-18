module ChaosAgent
  module Bankrupcy < Base
    LOW_VALUE = 30 # cents

    def perform(exchange)
      exchange.stocks.where('price < ?', LOW_VALUE).destroy!
    end
  end
end
