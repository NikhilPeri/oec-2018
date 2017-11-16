class SimulateJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :sidekiq

  def perform(exchange)
    begin
      exchange.step_time
    rescue => e
      puts "SOMETHING WENT WRONG: #{e.inspect}"
    end
    
    self.class.set(wait: exchange.update_frequency.minutes).perform_later(exchange) if exchange.live
  end
end
