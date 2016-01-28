class NotifyAnswerInSlack < ActiveJob::Base
  def perform(answer_id)
    answer = Answer.find(answer_id)
    SlackService.new.notify_answer(answer)
  end
end
