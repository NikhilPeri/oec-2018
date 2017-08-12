class Exchange < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_many :brokers, dependent: :destroy

  def start
    live = true
  end

  def pause
    live = false
  end

  def step_time
    return unless live

    self.time += 1

    self.stocks.each do |stock|
      stock.update_vectors
      stock.update_price
    end

    self.brokers.each do |broker|
      broker.update_portfolio
    end
  end
end
