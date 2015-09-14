class NotifyNewPostInSlack < ActiveJob::Base
  def perform(post_type, post_id)
    post = post_type.constantize.find(post_id)
    SlackService.new.notify post
  end
end
