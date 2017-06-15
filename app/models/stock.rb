class Stock < ApplicationRecord
  validates :ticker, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :generate_vectors

  def update_price
    price_vector = self.annual_vec +
                  self.quarterly_vec +
                  self.montly_vec +
                  self.week_vec +
                  self.day_vec

    self.price = self.price*price_vector
  end

  def generate_vectors

  end
end
