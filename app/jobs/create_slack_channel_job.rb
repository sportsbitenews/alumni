class CreateSlackChannelJob < ActiveJob::Base
  class SlackChannelCreationError < Exception; end

  def perform(batch_id)
    if ENV['AUTO_SLACK_CHANNEL_CREATION_ENABLED'] == 'true'
      batch = Batch.find(batch_id)

      params = {
        name: batch.slack_channel_name,
        token: ENV['SLACK_ALUMNI_ADMIN_TOKEN']
      }

      endpoint = "https://#{ENV['SLACK_ALUMNI_TEAM']}.slack.com/api/channels.create"
      response = RestClient.post endpoint, params, content_type: :json, accept: :json
      response_json = JSON.parse response.body

      if response_json["ok"]
        batch.update slack_id: response_json["channel"]["id"]
      elsif response_json["error"] == "name_taken"
        # Slack channel already exists
        params = {
          token: ENV['SLACK_ALUMNI_ADMIN_TOKEN']
        }
        endpoint = "https://#{ENV['SLACK_ALUMNI_TEAM']}.slack.com/api/channels.list"
        response = RestClient.post endpoint, params, content_type: :json, accept: :json
        response_json = JSON.parse response.body

        slack_id = response_json["channels"].select { |channel| channel["name"] == batch.slack_channel_name }.first["id"]
        batch.update slack_id: slack_id
      else
        fail SlackChannelCreationError, response.body
      end
    end
  end
end
