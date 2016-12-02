json.extract! post, :id, :title
json.type post.class.to_s  # Needed for polymorphic ReactJS
json.time_ago_in_words time_ago_in_words(post.created_at)
json.editable policy(post).update?

thumbnail = defined?(thumbnail) ? thumbnail : true
properties = user_properties
properties = properties - [ :photo_path ] unless thumbnail

json.user do
  json.extract! post.user, *(properties)
  if thumbnail
    json.thumbnail post.user.thumbnail(width: 53, height: 53, crop: :fill)
  end
end

json.up_voters do
  json.array! post.votes_for.includes(:voter).map do |vote|
    json.extract! vote.voter, *properties
    if thumbnail
      json.thumbnail vote.voter.thumbnail(width: 42, heigth: 42, crop: :fill)
    end
  end.zip(post.answers.includes(:user).map {|a| a.user})
end


if user_signed_in?
  json.up_voted current_user.voted_for? post
end
