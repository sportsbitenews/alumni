json.extract! post, :id, :title
json.type post.class.to_s  # Needed for polymorphic ReactJS

json.user do
  json.extract! post.user, :id, :github_nickname, :gravatar_url
end
json.up_votes do
  json.array! post.votes_for do |vote|
    json.extract! vote.voter, :id, :gravatar_url
  end
end
