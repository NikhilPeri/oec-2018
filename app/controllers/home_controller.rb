class HomeController < ApplicationController
  def index
    @brokers = Broker.all  
  end

end
