class ExchangeUpdateJob < ApplicationJob
  queue_as :default

  def perform(exchange)
    exchange.step_time

  end
end
