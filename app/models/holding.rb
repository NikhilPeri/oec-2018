class Holding < ApplicationRecord
  belongs_to :broker
  has_one :stock, :dependent => :destroy

  validates :broker_id, presence: true
  validates :stock_id, presence: true
  validates :shares, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def market_value
    return self.shares * self.stock.price
  end

  def earnings
    return market_value - self.book_cost
  end
end
