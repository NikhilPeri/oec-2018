class ResetHistoricalPortfolio < ActiveRecord::Migration[5.1]
  def change
    Brokers.all.each do |b|
      b.update(historical_portfolio: [])
      b.save
    end
  end
end
