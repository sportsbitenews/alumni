class CreateSlackChannelJob < ActiveJob::Base
  class SlackChannelCreationError < Exception; end

  def perform(batch_id)
    if ENV['AUTO_SLACK_CHANNEL_CREATION_ENABLED'] == 'true'
      batch = Batch.find(batch_id)

      params = {
        name: "batch-#{batch.slug}-#{batch.city.name.downcase}",
        token: ENV['SLACK_ALUMNI_ADMIN_TOKEN']
      }

      endpoint = "https://#{ENV['SLACK_ALUMNI_TEAM']}.slack.com/api/channels.create"
      response = RestClient.post endpoint, params, content_type: :json, accept: :json
      response_json = JSON.parse response.body

      if response_json["ok"]
        batch.update slack_id: response_json["channel"]["id"]
      else
        fail SlackChannelCreationError, response.body
      end
    end
  end
end
