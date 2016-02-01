json.extract! post, :id, :title
json.type post.class.to_s  # Needed for polymorphic ReactJS
json.time_ago_in_words time_ago_in_words(post.created_at)
json.editable policy(post).update?
json.user do
  json.extract! post.user, *user_properties
end

json.up_voters do
  json.array! post.votes_for.includes(:voter).map do |vote|
    json.extract! vote.voter, *user_properties
  end.zip(post.answers.includes(:user).map {|a| a.user})
end


if user_signed_in?
  json.up_voted current_user.voted_for? post
end

json.users do
  json.array! User.all do |user|
    json.partial! "posts/user", user: user
  end
end