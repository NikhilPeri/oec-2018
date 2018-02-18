module ChaosAgent
  module Base
    require 'rubystats'

    def perform(exchange)
      raise NotImplementedError
    end
  end
end
