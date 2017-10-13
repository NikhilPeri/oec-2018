class HomeController < ApplicationController
  def index
    @brokers = Brokers.find_by(exchange_id: 1)
  end
end
