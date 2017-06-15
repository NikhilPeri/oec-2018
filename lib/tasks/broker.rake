namespace :broker do

  desc "generate fake broker accounts"
  task :generate do
    Broker.all.each { |b| b.delete }

    b3 = Broker.new(name: "broker 1", email: "email1@fake.com", password: "pass")
    b3.save!

    b3 = Broker.new(name: "broker 2", email: "email2@fake.com", password: "pass")
    b3.save!

    b3 = Broker.new(name: "broker 3", email: "email3@fake.com", password: "pass")
    b3.save!

  end

  desc "clear remove all broker accounts"
  task :clear do
    Broker.all.each { |b| b.delete }
  end
end
