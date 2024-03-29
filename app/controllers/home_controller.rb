class HomeController < ApplicationController
  before_action :load_brokers, only: %w(index standings)

  def standings
    sorted_brokers = @brokers.sort { |b1, b2| b2.total_value <=> b1.total_value }
    render json: sorted_brokers.map{ |b| { name: b.name, data: b.historical_portfolio.map.with_index { |x, i| [i, x/100.0] } } }
  end

  def load_brokers
    @brokers = Broker.all
  end
end
