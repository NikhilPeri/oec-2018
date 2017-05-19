class BrokerController < ApplicationController
  before_action :load_broker

  private

  def load_broker
    @broker = Broker.find(token: params[:token])
  end
end
