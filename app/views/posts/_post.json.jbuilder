json.extract! post, :id, :title
json.type post.class.to_s  # Needed for polymorphic ReactJS

json.user do
  json.extract! post.user, :id, :github_nickname, :gravatar_url
end

json.up_votes do
  json.array! post.votes_for.includes(:voter).map do |vote|
    json.extract! vote.voter, :id, :gravatar_url, :github_nickname
    json.connected_to_slack false  # Too expensive to fetch here.
  end
end

if user_signed_in?
  json.up_voted current_user.voted_for? post
end

