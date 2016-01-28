class NotifyUpvoteInSlack < ActiveJob::Base
  def perform(answer)
    SlackService.new.notify_answer(answer)
  end
end
