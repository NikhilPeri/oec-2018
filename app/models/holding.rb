class Holding < ApplicationRecord
  belongs_to :broker
  has_one :stock, :dependent => :destroy

  validates :broker_id presence: true
  validates :stock_id presence: true
  validates :shares numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :complete_trnasaction

  def complete_transaction
    stock =  Stock.find(self.stock_id)
    self.book_cost = self.shares * stock.price

    self.broker.withdraw_cash(self.book_cost)
  end
end
