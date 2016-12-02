json.extract! user, *user_properties
json.thumbnail user.thumbnail(width: 180, height: 180, crop: :fill)

json.connected_to_slack user.connected_to_slack
json.user_messages_slack_url user.user_messages_slack_url

if user.staff
  json.badge 'staff'
elsif user.teacher
  json.badge 'teacher'
elsif user.teacher_assistant
  json.badge 'teaching assistant'
else
  json.badge 'alumni'
end

if user.batch
  json.batch do
    json.id user.batch.id
    json.slug user.batch.slug
    json.city user.batch.city.name
  end
end

json.votes do
  posts = []
  votable_ids = user.votes.pluck(:votable_id)
  Post::POST_TYPES.each do |post_type|
    posts << post_type.constantize.includes(*(post_type == 'Milestone' ? %i(user project) : [ :user ])).where(id: votable_ids)
  end
  posts = posts.flatten.sort_by { |post| post.created_at }.reverse

  json.array! posts.each do |post|
    type = post.class.to_s.underscore
    json.partial! "#{type}s/#{type}", :"#{type}" => post, thumbnail: false
  end
end

json.posts do
  posts = user.resources + user.questions + user.jobs + user.milestones
  json.array! posts.each do |post|
    type = post.class.to_s.underscore
    json.partial! "#{type}s/#{type}", :"#{type}" => post, thumbnail: false
  end
end
