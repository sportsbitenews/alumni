json.extract! user, *user_properties

json.cities user.cities.reduce('') { |cities, city| cities+="#{city.name} " }

json.slack do
  json.connected user.connected_to_slack
  json.messages_url user.user_messages_slack_url
  json.nickname SlackService.new.slack_username(user)
  json.uid user.slack_uid
end

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
