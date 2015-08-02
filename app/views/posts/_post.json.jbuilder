json.extract! post, :id, :title
json.type post.class.to_s  # Needed for polymorphic ReactJS

json.user do
  json.extract! post.user, *user_properties
end

json.up_voters do
  json.array! post.votes_for.includes(:voter).map do |vote|
    json.extract! vote.voter, *user_properties
    # Do not fetch Slack connection status here, too expensive
  end
end

if user_signed_in?
  json.up_voted current_user.voted_for? post
end

