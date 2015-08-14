json.name @batch.name
json.starts_at @batch.starts_at.strftime('%B ')
json.ends_at @batch.ends_at.strftime('%B %Y')
json.city @batch.city.name

json.students do
  json.array! @batch.users.each do |user|
    json.extract! user, :github_nickname, :gravatar_url
  end
end
