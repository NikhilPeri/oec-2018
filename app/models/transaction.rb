class Transaction < ApplicationRecord
  has_one :broker
  has_one :stock

  validates :shares, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :day, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :action, inclusion: %w(buy sell)
end
