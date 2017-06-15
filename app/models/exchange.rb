class Exchange < ApplicationRecord
  has_many :stocks

  def step_time
    self.time += 1
  end

  def generate_stock
    stock = Stock.new()
  end
end
