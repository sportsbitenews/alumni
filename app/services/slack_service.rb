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

  def send_slack_notif(post, attributes)
    options = slack_options(post, attributes)
    RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
  end

  def slack_attributes(instance, channel, notif_purpose, upvoter = nil)
    attributes = {}
    attributes[:channel] = channel
    if notif_purpose == :post
      attributes[:fallback] = instance.slack_fallback
      attributes[:pretext] = instance.slack_pretext
      attributes[:text] = instance.slack_text
    elsif notif_purpose == :upvote
      attributes[:title] = ":+1: #{instance.slack_title}"
      attributes[:author_name] = "#{upvoter.name} upvoted your #{instance.class.to_s.downcase}!"
      attributes[:author_link] = profile_url(upvoter.github_nickname)
      attributes[:author_icon] = upvoter.thumbnail(width: 75, height: 75, gravity: :face, crop: :thumb)
      attributes[:fallback] = "Your #{instance.class.to_s.downcase} was upvoted by #{upvoter.name}!"
      attributes[:pretext] = ""
      attributes[:text] = ""
    elsif notif_purpose == :answer
      attributes[:author_link] = profile_url(instance.user.github_nickname)
      attributes[:author_icon] = instance.user.thumbnail(width: 75, height: 75, gravity: :face, crop: :thumb)
      attributes[:fallback] = "@#{instance.user.github_nickname} commented on #{instance.answerable.slack_title}:"
      attributes[:pretext] = ""
      attributes[:text] = "<@#{slack_username(instance.user)}> _said_ #{instance.slack_content_preview}"
    elsif notif_purpose == :mention
      attributes[:title] = ":wave: #{instance.answerable.slack_title}"
      attributes[:author_name] = "#{instance.user.name} mentioned you in a comment!"
      attributes[:author_link] = profile_url(instance.user.github_nickname)
      attributes[:author_icon] = instance.user.thumbnail(width: 75, height: 75, gravity: :face, crop: :thumb)
      attributes[:fallback] = "#{instance.user.name} mentioned you in a comment!"
      attributes[:text] = "<@#{slack_username(instance.user)}> _said_ #{instance.slack_content_preview}"
    end
    return attributes
  end

  def slack_options(post, attributes = {})
    {
      channel: attributes[:channel],
      attachments: [{
        author_name: attributes[:author_name] || post.user.name,
        author_link: attributes[:author_link] || profile_url(post.user.github_nickname),
        author_icon: attributes[:author_icon] || post.user.thumbnail(width: 75, height: 75, gravity: :face, crop: :thumb),
        color: post.class::COLOR_FROM,
        title: attributes[:title] || post.slack_title,
        title_link: send(:"#{post.class.to_s.underscore}_url", post),
        mrkdwn_in: %w(text pretext),
        fallback: attributes[:fallback] || "",
        pretext: attributes[:pretext] || "",
        text: attributes[:text] || ""
      }]
    }
  end

  def connected_user_key(slack_uid)
    "connected:#{slack_uid}"
  end
end
