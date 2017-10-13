namespace :simulate do
  desc "start simulate job"
  task :start => :environment do
    exchange = Exchange.first
    exchange.update(live: true)
    SimulateJob.perform_now(exchange)
  end
end
