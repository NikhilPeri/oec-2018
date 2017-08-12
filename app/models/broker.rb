class Broker < ApplicationRecord
  has_secure_password

  belongs_to :exchange
  has_many :holdings, :dependent => :destroy

  after_initialize :assign_token
  after_initialize :assign_cash

  validates :name, presence: true
  validates :token, presence: true

  def update_portfolio
    self.historical_portfolio << holding_value + self.cash
  end

  def holding_value
    holding_value = 0;
    self.holdings.each { |h| holding_value += h.value }
    return holding_value
  end

  def assign_token
    self.token ||= SecureRandom.urlsafe_base64(nil, false)
  end

  def assign_cash
    self.cash ||= 10000000
  end

  def withdraw_cash(amount)
    self.cash -= amount
  end

  def deposit_cash(amount)
    self.cash += amount
  end
end
