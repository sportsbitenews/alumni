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

  def user_messages_slack_url(user)
    username = slack_username(user)
    "https://lewagon-alumni.slack.com/messages/@#{username}" if username
  end

  def notify(post)
    attributes = slack_attributes(post, ENV['SLACK_INCOMING_WEBHOOK_CHANNEL'], :post)
    send_slack_notif(post, attributes)
  end

  def notify_upvote(post, upvoter)
    slack_nickname = slack_username(post.user)
    if slack_nickname
      attributes = slack_attributes(post, "@#{slack_nickname}", :upvote, upvoter)
      send_slack_notif(post, attributes)
    end
  end

  def notify_answer(answer)
    post = answer.answerable
    answerer = answer.user
    attributes = slack_attributes(answer, "", :answer)
    # send slack DM to other answerers
    other_answerers = post.answers.map(&:user).uniq - [answerer, post.user]
    other_answerers.each do |other_answerer|
      other_answerer_slack_nickname = slack_username(other_answerer)
      if other_answerer_slack_nickname
        attributes[:channel] = "@#{other_answerer_slack_nickname}"
        send_slack_notif(post, attributes)
      end
    end
    # send slack DM to upvoters (except answerers and post.user)
    upvoters = post.votes_for.up.voters.reject { |voter| voter.id == answerer.id || voter.id == post.user.id || other_answerers.map(&:id).include?(voter.id) }
    upvoters.each do |upvoter|
      upvoter_slack_nickname = slack_username(upvoter)
      if upvoter_slack_nickname
        attributes[:channel] = "@#{upvoter_slack_nickname}"
        attributes[:pretext] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}> commented on a #{post.class.to_s.downcase} you upvoted, check it out!"
        send_slack_notif(post, attributes)
      end
    end
    # send slack DM to post owner (unless he answered on his post)
    post_owner_slack_nickname = slack_username(post.user)
    if post_owner_slack_nickname && post.user != answerer
      attributes[:channel] = "@#{post_owner_slack_nickname}"
      attributes[:pretext] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}> commented on your #{post.class.to_s.downcase}, check it out!"
      send_slack_notif(post, attributes)
    end
  end

  private

  def send_slack_notif(post, attributes)
    options = slack_options(post, attributes)
    p options
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
      attributes[:fallback] = "Your #{instance.class.to_s.downcase} was upvoted by #{upvoter.name}!"
      attributes[:pretext] = "Your #{instance.class.to_s.downcase} was upvoted, check it out!"
      attributes[:text] = "<#{profile_url(upvoter.github_nickname)}|@#{upvoter.github_nickname}> upvoted your #{instance.class.to_s.downcase}!"
    elsif notif_purpose == :answer
      attributes[:fallback] = "@#{instance.user.github_nickname} commented on #{instance.answerable.slack_title}:"
      attributes[:pretext] = "<#{profile_url(instance.user.github_nickname)}|@#{instance.user.github_nickname}> commented on a #{instance.answerable.class.to_s.downcase} you also commented, check it out!"
      attributes[:text] = "<#{profile_url(instance.user.github_nickname)}|@#{instance.user.github_nickname}>: #{instance.slack_content_preview}"
    end
    return attributes
  end

  def slack_options(post, attributes = {})
    {
      channel: attributes[:channel],
      attachments: [{
        author_name: post.user.name,
        author_link: profile_url(post.user.github_nickname),
        author_icon: post.user.thumbnail,
        color: post.class::COLOR_FROM,
        title: post.slack_title,
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
