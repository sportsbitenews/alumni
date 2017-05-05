class SlackController < ActionController::Base
  def interactive_message
    @payload = JSON.parse(params[:payload])
    if legit?
      case action
      when "onboarding"
        render json: onboarding
      else
        raise NotImplementedError.new("#{@action} is unknown")
      end
    end
  end

  private

  def onboarding
    if value == 'confirmed'
      user = User.find(@payload["callback_id"].split("_").last)
      if user.nil?
        {
          "response_type": "ephemeral",
          "replace_original": false,
          "text": "Sorry, Could not find this user in the database. Ask @ssaunier"
        }
      else
        unless user.alumni
          user.alumni = true
          user.save!
          OnboardUserJob.perform_later(user.id)
        end

        {
          "text": "*#{user.name}* has been onboarded in *Batch ##{user.batch.slug} - #{user.batch.city.name}*",
          "attachments": [
            {
              "color": "#60C275",
              "thumb_url": user.gravatar_url,
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
              ]
            },
            {
              "color": "#4484C2",
              "text": "<#{ENV['KITT_BASE_URL']}/camps/#{user.batch.slug}/classmates|View #{user.batch.users.length} classmates>"
            }
          ]
        }
      end
    end
  end

  def legit?
    @payload["token"] == ENV['SLACK_ALUMNI_VERIFICATION_TOKEN']
  end

  def action
    @payload["actions"].first["name"]
  end

  def value
    @payload["actions"].first["value"]
  end

  def original_ts
    @payload["original_message"]["ts"]
  end
end
