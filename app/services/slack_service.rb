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
        response["user"].try("name")
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

  def user_messages_slack_url(user)
    username = slack_username(user)
    "https://lewagon-alumni.slack.com/messages/@#{username}" if username
  end

  def notify(post)
    options = {
      channel: ENV['SLACK_INCOMING_WEBHOOK_CHANNEL'],
      attachments: [{
        author_name: post.user.name,
        author_link: profile_url(post.user.github_nickname),
        author_icon: post.user.gravatar_url,
        fallback: post.slack_fallback,
        pretext: post.slack_pretext,
        color: post.class::COLOR_FROM,
        title: post.slack_title,
        title_link: send(:"#{post.class.to_s.underscore}_url", post),
        text: post.slack_text,
        mrkdwn_in: %w(text pretext)
      }]
    }
    RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
  end

  private

  def connected_user_key(slack_uid)
    "connected:#{slack_uid}"
  end
end
