class NotifyMentionInSlack < ActiveJob::Base
  def perform(answer_id, user_id)
    answer = Answer.find(answer_id)
    user = User.find(user_id)
    SlackService.new.notify_mention(answer, user)
  end
end
