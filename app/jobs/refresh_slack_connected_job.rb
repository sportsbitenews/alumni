class RefreshSlackConnectedJob < ActiveJob::Base
  def perform
    SlackService.new.refresh_all_connected
  end
end

Sidekiq::Cron::Job.create(
  name: 'Refresh Connected to slack property for each user',
  cron: '*/5 * * * *',
  klass: 'RefreshSlackConnectedJob')
