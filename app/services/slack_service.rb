require "slack"

class SlackService
  include Cache

  def initialize(options = {})
    token = options.fetch(:token, ENV['SLACK_ALUMNI_ADMIN_TOKEN'])
    @client = Slack::Client.new token: token
  end

  def connected_to_slack?(user)
    if user.slack_uid.present?
      from_cache('connected', user.id) do
        response = @client.users_getPresence(user: user.slack_uid)
        response["presence"] == "active"
      end
    else
      false
    end
  end

  def slack_username(user)
    if user.slack_uid.present?
      from_cache('username', user.id, expire: 1.day) do
        response = @client.users_info(user: user.slack_uid)
        response["user"]["name"]
      end
    end
  end

  def user_messages_slack_url(user)
    username = slack_username(user)
    "https://lewagon-alumni.slack.com/messages/@#{username}" if username
  end
end
