class InsufficientFundsError < StandardError; end
class InsufficientHoldingsError < StandardError; end

class Broker < ApplicationRecord
  has_secure_password

  belongs_to :exchange
  has_many :holdings, :dependent => :destroy

  after_initialize :assign_token
  after_initialize :assign_cash

  validates :name, presence: true
  validates :token, presence: true

  def buy(stock, shares)
    withdraw_cash(shares*stock.price)

    holding = self.holdings.find_by(stock: stock) || Holding.new(broker: self, stock: stock)
    holding.add_shares(shares)
    holding.save!
  end

  def sell(stock, shares)
    holding = self.holdings.find_by(stock: stock)
    raise InsufficientHoldingsError if holding.nil? || shares > holding.shares

    deposit_cash(holding.stock_price*shares)
    holding.remove_shares(shares)
    
    if holding.shares.zero?
      holding.destroy
    else
      holding.save!
    end
  end

  def update_portfolio
    self.historical_portfolio << holding_value + self.cash
  end

  def holding_value
    holding_value = 0;
    self.holdings.each { |h| holding_value += h.marker_value }
    return holding_value
  end

  def assign_token
    self.token ||= SecureRandom.urlsafe_base64(nil, false)
  end

  def assign_cash
    self.cash ||= 10000000
  end

  def withdraw_cash(amount)
    raise InsufficientFundsError if amount > self.cash
    self.cash -= amount
  end

  def deposit_cash(amount)
    self.cash += amount
  end
end
