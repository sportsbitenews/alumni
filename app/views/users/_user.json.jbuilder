json.extract! user, *user_properties

json.connected_to_slack user.connected_to_slack
json.user_messages_slack_url user.user_messages_slack_url

json.badge user.badge

json.batch user.algolia_batch

# json.votes do
#   json.array! user.votes.each do |vote|
#     post = vote.votable_type.constantize.find(vote.votable_id)
#     type = post.class.to_s.underscore
#     json.partial! "#{type}s/#{type}", :"#{type}" => post
#   end
# end

# json.posts do
#   posts = user.resources + user.questions + user.jobs + user.milestones
#   json.array! posts.each do |post|
#     type = post.class.to_s.underscore
#     json.partial! "#{type}s/#{type}", :"#{type}" => post
#   end
# end
