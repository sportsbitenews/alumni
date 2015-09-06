class OnboardUserJob < ActiveJob::Base
  def perform(user_id)
    if ENV['AUTO_ONBOARDING_ENABLED'] == 'true'
      PushUserToKittJob.perform_later(user_id)
      InviteNewUserToSlackJob.perform_later(user_id)
    end
  end
end
