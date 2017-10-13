class HomeController < ApplicationController
  def index
    @brokers = Broker.find_by(exchange_id: 1)
  end
end
