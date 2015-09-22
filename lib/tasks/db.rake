namespace :db do
  desc "Backs up heroku database and restores it locally. Needs `heroku addons:add pgbackups` first"
  task import_from_heroku: :environment do
    c = Rails.configuration.database_configuration[Rails.env]
    Bundler.with_clean_env do
      puts "[1/4] Capturing backup on Heroku"
      `heroku pg:backups capture DATABASE_URL`
      puts "[2/4] Downloading backup onto disk"
      `curl -o latest.dump \`heroku pg:backups public-url | cat\``
      puts "[3/4] Mounting backup on local database"
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{c["database"]} latest.dump`
      puts "[4/4] Removing local backup"
      `rm latest.dump`
      puts "Done."
    end
  end

  task import_kitt_users: :environment do
    kitt_users = YAML.load_file(Rails.root.join('db/kitt_users_dump.yml'))
    kitt_users.each do |kitt_user|
      user = User.new(
        kitt_user.slice(:email,
                        :github_nickname,
                        :github_token,
                        :gravatar_url,
                        :slack_uid,
                        :slack_token,
                        :phone
        ))
      # TODO: use camp_id for Batch
      if kitt_user[:camp_approved]
        user.alumni = true
      end
      if user.save
        puts "Imported #{user.github_nickname}"
      end
    end
  end
end
