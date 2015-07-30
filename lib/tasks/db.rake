namespace :db do
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
