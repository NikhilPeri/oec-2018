namespace :admin do

  desc "reset admin account"
  task :clear do
    Admin.all.each { |a| a.delete }
  end
end
