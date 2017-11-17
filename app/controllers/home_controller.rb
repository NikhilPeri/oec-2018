class HomeController < ApplicationController
  before_action :load_brokers, only: %w(index standings)

  def standings
    #@brokers.sort { |b1, b2| b2.total_value <=> b1.total_value }

    render json: Stock.all.sample(4).map{ |b| { name: b.ticker, data: b.historical_price.map.with_index { |x, i| [i.hours.from_now - 1.year, x] } } }
  end

  def load_brokers
    @brokers = Broker.all
  end
end
