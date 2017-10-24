class SimulateJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :sidekiq

  def perform(exchange)
    exchange.step_time

    self.class.set(wait: exchange.update_frequency.minutes).perform_later(exchange) if exchange.live
  end
end
