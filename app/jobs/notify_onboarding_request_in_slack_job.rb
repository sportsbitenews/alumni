class NotifyOnboardingRequestInSlackJob < ActiveJob::Base
  include Rails.application.routes.url_helpers

  def perform(user_id)
    user = User.find(user_id)
    channel = user.batch.city.slack_channel_name
    RestClient.post "https://slack.com/api/chat.postMessage",
      slack_options(user, channel, ENV['TEAMWAGON_SLACK_BOT_TOKEN'])
  end

  private

  def slack_options(user, channel, token)
    {
      "channel": channel,
      "token": token,
      "text": "*#{user.name}* wants to join *Batch ##{user.batch.slug} - #{user.batch.city.name}*",
      "attachments": [
        {
          "fallback": "#{user.name} wants to join Batch ##{user.batch.slug}",
          "callback_id": "onboarding_#{user.id}",
          "thumb_url": user.gravatar_url,
          "color": "#DDDDDD",
          "attachment_type": "default",
          "fields": [
            {
              "title": "School",
              "value": user.school,
              "short": true
            },
            {
              "title": "Born on",
              "value": user.birth_day.strftime("%b %d, %Y"),
              "short": true
            },
            {
              "title": "Bio",
              "value": user.private_bio
            }
          ],
          "actions": [
            {
              "name": "onboarding",
              "text": "Confirm Onboarding",
              "type": "button",
              "style": "primary",
              "value": "confirmed",
              "confirm": {
                "title": "Are you sure?",
                "text": "The user will be added to Kitt, Karr and Slack",
                "ok_text": "Onboard #{user.first_name}",
                "dismiss_text": "Cancel"
              }
            }
          ]
        }
      ].to_json
    }
  end
end
