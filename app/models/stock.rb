require 'rubystats'

class Stock < ApplicationRecord
  belongs_to :exchange

  validates :exchange, presence: true
  validates :ticker, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :generate_defaults

  def generate_defaults
    self.price ||= 100 + Random.rand(50000)
    self.historical_price = [ self.price ] if self.historical_price.empty?
    self.ticker ||= ('A'..'Z').to_a.shuffle[0..2].join

    self.annual_vec ||= Rubystats::NormalDistribution.new(0, 0.001).rng
    self.intermediate_vec ||= Rubystats::NormalDistribution.new(self.annual_vec, volitility).rng
    self.daily_vec ||= Rubystats::NormalDistribution.new(self.intermediate_vec, volitility).rng
  end

  def update_price
    self.price *= 1 + self.daily_vec
    self.price = self.price.round

    self.historical_price << self.price
  end

  def update_vectors
    if self.exchange.day % 365
      self.annual_vec = Rubystats::NormalDistribution.new(0, 0.001).rng
    end

    if self.exchange.day % 15
      self.intermediate_vec = Rubystats::NormalDistribution.new(self.annual_vec, volitility).rng
    end

    self.daily_vec ||= Rubystats::NormalDistribution.new(self.intermediate_vec, volitility).rng
  end

  def volitility
    0.003
  end
end
