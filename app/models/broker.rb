class Broker < ApplicationRecord
  has_secure_password

  belongs_to :exchange
  has_many :holdings, dependent: :destroy
  has_many :transactions, dependent: :destroy

  before_validation  :assign_token
  before_validation :assign_cash
  before_validation :assign_exchange

  validates :exchange, presence: true
  validates :name, presence: true
  validates :token, presence: true
  validates :email, uniqueness: true

  class InsufficientFundsError < StandardError; end
  class InsufficientSharesError < StandardError; end

  def buy(stock, shares)
    withdraw_cash(shares*stock.price)
    transactions.create(action: 'buy', stock: stock, shares: shares, day: exchange.day)

    holding = holdings&.find_by(stock: stock) || Holding.new(broker: self, stock: stock)
    holding.add_shares(shares)
    holding.save!
  end

  def sell(stock, shares)
    holding = holdings&.find_by(stock: stock)
    raise InsufficientSharesError if holding.nil? || shares > holding.shares
    transactions.create(action: 'sell', stock: stock, shares: shares, day: exchange.day)

    deposit_cash(holding.stock_price*shares)
    holding.remove_shares(shares)

    if holding.shares.zero?
      holding.destroy!
    else
      holding.save!
    end
  end

  def historical_price
    historical_portfolio.map { |price| price/100.0 }
  end

  def update_portfolio
    historical_portfolio << total_value
  end

  def total_value
    holding_value + cash
  end

  def holding_value
    holdings.sum { |holding| holding.market_value }
  end

  def assign_token
    self.token ||= SecureRandom.urlsafe_base64(nil, false)
  end

  def assign_cash
    self.cash ||= 10000000
  end

  def assign_exchange
    self.exchange = Exchange.first
  end

  def withdraw_cash(amount)
    raise InsufficientFundsError if amount > self.cash
    self.cash -= amount
  end

  def deposit_cash(amount)
    self.cash += amount
  end
end
