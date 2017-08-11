class Exchange < ApplicationRecord
  has_many :stocks

  def step_time
    self.time += 1

    self.stocks.each do |stock|
      stock.update_vectors
      stock.update_price
    end
  end
end
