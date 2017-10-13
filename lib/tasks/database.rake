namespace :database do
  desc "setup database on new server"
  task :populate => :environment do
    STDOUT.puts "Enter admin password:"
    password = STDIN.gets.strip

    if Exchange.count.zero?
      exchange = Exhange.new
      exchange.save
    end

    if Admin.count.zero?
      admin = Admin.new(exchange: exchange, name: 'Nikhil Peri', email: 'fake@email.com', password: password)
      admin.save
    end

    if Broker.count.zero?
      broker = Broker.new(exchange: exchange, name: 'Test Broker', email: 'fake@email.com', password: password)
      broker.save
    end

    100.times do
      stock = Stock.new(exchange: exchange)
      stock.save
    end
  end
end
