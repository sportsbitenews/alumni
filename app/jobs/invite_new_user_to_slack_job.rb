class InviteNewUserToSlackJob < ActiveJob::Base
  class SlackInviteNewUserError < Exception; end

  def perform(user_id)
    user = User.find(user_id)

    params = {
      channels: user.batch.slack_id,
      token: ENV['SLACK_ALUMNI_ADMIN_TOKEN'],
      set_active: true,
      email: user.email
    }

    endpoint = "https://#{ENV['SLACK_ALUMNI_TEAM']}.slack.com/api/users.admin.invite"
    response = RestClient.post endpoint, params, content_type: :json, accept: :json
    response_json = JSON.parse response.body

    if !response_json["ok"] && response_json["error"] != "already_in_team" && response_json["error"] != "already_invited"
      fail SlackInviteNewUserError, response.body
      # Slack only returns {"ok": true}, at this point, we do not have any user slack uid (not yet registered)
    end
  end
end
