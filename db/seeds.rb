# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

exchange = Exchange.new()
exchange.save!

30.times do
  Stock.new(exchange: exchange).save!
end

15.times do
  broker = Broker.new(exchange: exchange)
end
