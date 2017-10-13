namespace :database do
  desc "setup database on new server"
  task :populate => :environment do
    STDOUT.puts "Enter admin password:"
    password = STDIN.gets.strip

    exchange = Exchange.new
    exchange.save if Exchange.count.zero?

    if Admin.count.zero?
      admin = Admin.new(exchange: exchange, name: 'Nikhil Peri', email: 'fake@email.com', password: password)
      admin.save
    end

    if Broker.count.zero?
      broker = Broker.new(exchange: exchange, name: 'Test Broker', email: 'fake@email.com', password: password)
      broker.save
    end

    10.times do
      stock = Stock.new(exchange: exchange)
      binding.pry
      stock.save
    end
  end

  desc "nuke all existing databases"
  task :nuke => :environment do
    Exchange.delete_all!
  end
end
