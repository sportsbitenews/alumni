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

  task :invite_users_to_city_channel, [:city_slug] => :environment do |t, args|
    city = City.find_by(slug: args[:city_slug])
    if city && !city.slack_channel_id.blank?
      puts "Beginning invitations to #{city.name} slack channel..."
      users_slack_uids = city.users.map { |user| { user.name => user.slack_uid } }.reject { |hash| hash.values.first.blank? }
      users_slack_uids.each do |users_slack_uid|
        RestClient.post "https://slack.com/api/channels.invite?token=#{ENV["SLACK_ALUMNI_ADMIN_TOKEN"]}&channel=#{city.slack_channel_id}&user=#{users_slack_uid.values.first}&pretty=1", {}
        puts "Invited #{users_slack_uid.values.first} to #{city.name} channel..."
      end
      puts "All invites sent"
      puts "#{city.users.where(slack_uid: nil.count)} users not invited (no slack uid)"
    end
  end
end
