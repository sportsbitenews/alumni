class NotifyAnswerInSlack < ActiveJob::Base
  def perform(post, user)
    SlackService.new.notify_upvote(post, user)
  end
end
