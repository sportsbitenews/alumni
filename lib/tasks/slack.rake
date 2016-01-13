namespace :slack do
  desc "Refresh all slack 'connected' status"
  task refresh: :environment do
    puts "Refreshing..."
    RefreshSlackConnectedJob.perform_now
    puts "Done"
  end

  task associate_users: :environment do
    slack_users = SlackService.new.users.reduce(Hash.new) do |h, user|
      h[user["profile"]["email"]] = user
      h
    end

    User.where(slack_uid: nil).each do |user|
      if slack_user = slack_users[user.email]
        user.slack_uid = slack_user["id"]
        user.save
        puts "Linked #{user.name}"
      end
    end

    puts "Still #{User.where(slack_uid: nil).count} users without slack uid"
  end
end
