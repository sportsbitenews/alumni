require "slack"

class SlackService
  include Cache
  include Rails.application.routes.url_helpers

  def initialize(options = {})
    token = options.fetch(:token, ENV['SLACK_ALUMNI_ADMIN_TOKEN'])
    @client = Slack::Client.new token: token
  end

  def connected_to_slack(user)
    if user.slack_uid.present?
      redis.get(connected_user_key(user.slack_uid)) == "1"
    else
      false
    end
  end

  def slack_username(user)
    if user.slack_uid.present?
      from_cache('username', user.id, expire: 1.day) do
        response = @client.users_info(user: user.slack_uid)
        response["user"] ? response["user"]["name"] : nil
      end
    end
  end

  def refresh_all_connected
    @client.users_list(presence: 1)["members"].each do |member|
      key = connected_user_key(member["id"])
      active = (member["presence"] == "active") ? "1" : "0"
      redis.set(key, active)
      redis.expire(key, 10.minutes)
    end
  end

  def users
    @client.users_list["members"]
  end

  def users_by_email
    users.reduce(Hash.new) do |h, user|
      h[user["profile"]["email"]] = user
      h
    end
  end

  def user_messages_slack_url(user)
    username = slack_username(user)
    "https://lewagon-alumni.slack.com/messages/@#{username}" if username
  end

  private

  def connected_user_key(slack_uid)
    "connected:#{slack_uid}"
  end
end
