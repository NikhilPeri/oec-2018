require 'digest/md5'

class Broker < ApplicationRecord
  attr_reader :name, :token
  attr_accessor :cash

  has_many :holdings, dependant: :destroy

  def initialize(name)
    super
    @name = name
    @token = Digest::MD5.hexdigest(name)
    @cash = 1000000
  end
end
