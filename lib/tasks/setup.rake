namespace :setup do
  desc "seeds database wieth required accounts"
  task :seeds => :environment do
    Holding.delete_all
    Admin.delete_all
    Broker.delete_all
    Stock.delete_all
    Exchange.delete_all
    exchange = Exchange.new
    exchange.save!

    STDOUT.puts "Enter admin password:"
    password = STDIN.gets.strip

    puts "\n=== Creating Admin Account ==="
    admin = Admin.new(exchange: exchange, name: 'Nikhil Peri', email: 'fake@email.com', password: password)
    admin.save!
    puts admin.inspect

    puts "\n=== Creating Test Broker Account ==="
    #broker = Broker.new(exchange: exchange, name: 'Test Broker', email: 'fake@email.com', password: password)
    #broker.save!
    #puts broker.inspect

    puts "\n=== Creating Stocks ==="
    30.times do
      stock = Stock.new(exchange: exchange)
      stock.save!
      puts stock.inspect
    end
  end

  task :simulate => :environment do
    puts "simulating stocks"
    e = Exchange.first
    e.update!(live: true)
    240.times { SimulateJob.perform(e) }
  end
end
