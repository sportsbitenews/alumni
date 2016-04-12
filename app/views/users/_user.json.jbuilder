json.extract! user, *user_properties

json.connected_to_slack user.connected_to_slack
json.user_messages_slack_url user.user_messages_slack_url

if user.staff
  json.badge 'staff'
elsif user.teacher
  json.badge 'teacher'
elsif user.teacher_assistant
  json.badge 'teacher assistant'
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
