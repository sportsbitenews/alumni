class InviteNewUserToSlackJob < ActiveJob::Base
  def perform(email, channel = nil)
    params = {
      channels: [ "#general", channel ].compact,
      token: ENV['SLACK_ALUMNI_ADMIN_TOKEN'],
      set_active: true,
      email: email
    }
    endpoint = "https://lewagon-alumni.slack.com/api/users.admin.invite"
    RestClient.post endpoint, params.to_json, content_type: :json, accept: :json
  end
end
