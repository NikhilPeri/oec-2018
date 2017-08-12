class InsufficientHoldingsError < StandardError; end

class Holding < ApplicationRecord
  belongs_to :broker
  belongs_to :stock

  validates :broker_id, presence: true
  validates :stock_id, presence: true
  validates :shares, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  def set_defaults
    self.shares ||= 0
    self.book_cost ||= 0
  end

  def add_shares(num_shares)
    self.shares += num_shares
    self.book_cost += num_shares * self.stock.price
  end

  def remove_shares(shares)
    raise InsufficientHoldingsError if num_shares > self.shares
    avg_book_cost = self.book_cost / self.shares
    self.shares -= num_shares
    self.book_cost = avg_book_cost * self.shares
  end

  def market_value
    return self.shares * self.stock.price
  end

  def earnings
    return market_value - self.book_cost
  end
end
