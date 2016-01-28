class NotifyUpvoteInSlack < ActiveJob::Base
  def perform(post_id, post_class, user_id)
    post = post_class.constantize.find(post_id)
    user = User.find(user_id)
    SlackService.new.notify_upvote(post, user)
  end
end
