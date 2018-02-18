class Exchange < ApplicationRecord
  has_many :admins, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :brokers, dependent: :destroy

  attribute :day, default: 1
  attribute :update_frequency, default: 1
  attribute :live, default: false

  CHAOS_AGENTS = [
    ChaosAgent::Fourier,
    ChaosAgent::Bankrupcy,
    ChaosAgent::Ipo,
    ChaosAgent::Bear,
    ChaosAgent::Bull,
    ChaosAgent::Buyer,
    ChaosAgent::Seller,
  ]

  def start
    self.update!(live: true)
    SimulateJob.perform_later(self)
  end

  def pause
    self.update!(live: false)
  end

  def step_time
    return unless self.live

    self.day += 1

    CHAOS_AGENTS.each do { |agent| agent.perform(self) }

    self.stocks.each do |stock|
      stock.update_price
      stock.save!
    end

    self.brokers.each do |broker|
      broker.update_portfolio
      broker.save!
    end
  end
end
