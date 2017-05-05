namespace :batch do
  desc "Reset Onboarding for all batches"
  task reset_onboarding: :environment do
    Batch.where.not(slug: [nil, ""]).each do |batch|
      today = Time.find_zone!(batch.time_zone).today
      starts_at = batch.starts_at.in_time_zone(batch.time_zone).to_date
      if starts_at == today
        if !batch.onboarding
          batch.update(onboarding: true)
          puts "Batch ##{batch.slug} - #{batch.city.name} is now onboarding."
        end
      elsif today > starts_at && batch.onboarding
        batch.update(onboarding: false)
        puts "Batch ##{batch.slug} - #{batch.city.name} is not onboarding anymore."
      end
    end
  end
end
