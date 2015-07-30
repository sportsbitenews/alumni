require "slack"

class SlackService
  include Cache

  def initialize(options = {})
    token = options.fetch(:token, ENV['SLACK_ALUMNI_ADMIN_TOKEN'])
    @client = Slack::Client.new token: token
  end

  def connected_to_slack?(user)
    from_cache('connected', user.id) do
      if user.slack_uid.present?
        response = @client.users_getPresence(user: user.slack_uid)
        response["presence"] == "active"
      else
        false
      end
    end
  end
end
