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

  def users
    @client.users_list["members"]
  end

  def user_messages_slack_url(user)
    username = slack_username(user)
    "https://lewagon-alumni.slack.com/messages/@#{username}" if username
  end

  def notify(post)
    options = slack_options(post)
    options[:channel] = ENV['SLACK_INCOMING_WEBHOOK_CHANNEL']
    options[:attachments][0][:fallback] = post.slack_fallback
    options[:attachments][0][:pretext] = post.slack_pretext
    options[:attachments][0][:text] = post.slack_text
    RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
  end

  def notify_upvote(post, upvoter)
    if slack_username(post.user)
      options = slack_options(post)
      options[:channel] = "@#{slack_username(upvoter)}"
      options[:attachments][0][:fallback] = "Your #{post.class.to_s.downcase} was upvoted!"
      options[:attachments][0][:pretext] = "Your #{post.class.to_s.downcase} was upvoted, check it out!"
      options[:attachments][0][:text] = "<#{profile_url(upvoter.github_nickname)}|@#{upvoter.github_nickname}> upvoted your #{post.class.to_s.downcase}!"
      RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
    end
  end

  def notify_answer(answer)
    post = answer.answerable
    options = slack_options(post)
    answerer = answer.user
    # send slack DM to other answerers
    other_answerers = post.answers.map(&:user).uniq - [answerer, post.user]
    other_answerers.each do |other_answerer|
      if slack_username(other_answerer)
        options[:channel] = "@#{slack_username(other_answerer)}"
        options[:attachments][0][:fallback] = "@#{answerer.github_nickname} commented on #{post.slack_title}:"
        options[:attachments][0][:pretext] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}> commented on a #{post.class.to_s.downcase} you also commented, check it out!"
        options[:attachments][0][:text] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}>: #{answer.slack_content_preview}"
        RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
      end
    end
    # send slack DM to upvoters (except answerers and post.user)
    upvoters = post.votes_for.up.voters.reject { |voter| voter.id == answerer.id || voter.id == post.user.id || other_answerers.map(&:id).include?(voter.id) }
    upvoters.each do |upvoter|
      if slack_username(upvoter)
        options[:channel] = "@#{slack_username(upvoter)}"
        options[:attachments][0][:pretext] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}> commented on a #{post.class.to_s.downcase} you upvoted, check it out!"
        RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
      end
    end
    # send slack DM to post owner (unless he answered on his post)
    if slack_username(post.user) && post.user != answerer
      options[:channel] = "@#{slack_username(post.user)}"
      options[:attachments][0][:pretext] = "<#{profile_url(answerer.github_nickname)}|@#{answerer.github_nickname}> commented on your #{post.class.to_s.downcase}, check it out!"
      RestClient.post ENV['SLACK_INCOMING_WEBHOOK_URL'], options.to_json, content_type: :json, accept: :json
    end
  end

  private

  def slack_options(post)
    {
      attachments: [{
        author_name: post.user.name,
        author_link: profile_url(post.user.github_nickname),
        author_icon: post.user.thumbnail,
        color: post.class::COLOR_FROM,
        title: post.slack_title,
        title_link: send(:"#{post.class.to_s.underscore}_url", post),
        mrkdwn_in: %w(text pretext)
      }]
    }
  end

  def connected_user_key(slack_uid)
    "connected:#{slack_uid}"
  end
end
