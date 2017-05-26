class Broker < ApplicationRecord
  has_many :holdings, :dependent => :destroy

  attr_accessor :cash

  after_initialize :assign_token
  after_initialize :assign_cash

  validates :name, presence: true
  validates :token, presence: true

  def assign_token
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end

  def assign_cash
    self.cash = 10000000
  end

  def withdraw_cash(amount)
    self.cash -= amount
  end

  def deposit_cash(amount)
    self.cash += amount
  end
end
