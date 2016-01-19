namespace :mailchimp do
  task :subscribe_batch, [:batch_slug] => :environment do |t, args|
    batch = Batch.find_by_slug(args[:batch_slug])
    if batch
      batch.users.each do |user|
        Mailchimp.new.subscribe_to_alumni_list(user)
        puts "Subscribed #{user.github_nickname}"
      end
      puts "Subscribed #{batch.users.size} alumni from batch #{args[:batch_slug]}"
    else
      puts "Could not find batch with slug #{args[:batch_slug]}"
    end
  end
end
