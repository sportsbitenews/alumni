namespace :slack do
  desc "Refresh all slack 'connected' status"
  task refresh: :environment do
    puts "Refreshing..."
    RefreshSlackConnectedJob.perform_now
    puts "Done"
  end
end
