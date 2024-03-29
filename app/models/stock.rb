require 'rubystats'

class Stock < ApplicationRecord
  belongs_to :exchange
  has_many :holdings, dependent: :destroy

  validates :exchange, presence: true
  validates :ticker, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :generate_defaults

  VOLITILITY = 0.09

  def generate_defaults
    return if persisted?
    self.price ||= 100 + Random.rand(50000)
    self.historical_price = [ self.price ] if self.historical_price.empty?
    self.ticker ||= ('A'..'Z').to_a.shuffle[0..2].join

    self.annual_vec ||= Rubystats::NormalDistribution.new(0, 0.1).rng
    self.intermediate_vec ||= Rubystats::NormalDistribution.new(self.annual_vec, VOLITILITY).rng
    self.daily_vec ||= Rubystats::NormalDistribution.new(self.intermediate_vec, VOLITILITY).rng
  end

  def update_price
    self.price *= 1 + ( self.daily_vec )
    self.price = self.price.round

    self.historical_price << self.price
  end

  def to_param
    self.ticker
  end
end
