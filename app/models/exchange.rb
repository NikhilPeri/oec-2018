class Exchange < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :brokers, dependent: :destroy

  attribute :day, default: 1
  attribute :update_frequency, default: 3
  attribute :live, default: false

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

    self.stocks.each do |stock|
      stock.update_vectors
      stock.update_price
      stock.save!
    end

    self.brokers.each do |broker|
      broker.update_portfolio
      broker.save!
    end
  end
end
