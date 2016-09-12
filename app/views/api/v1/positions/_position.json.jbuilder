json.id position.id
json.title position.title

if position.company
  json.company do
    json.name position.company.name
    json.url position.company.url
    json.logo position.company.logo.url(:thumbnail)
  end
end
user = position.user
if user
  json.alumni do
    json.extract! user , :id, :github_nickname, :first_name, :last_name, :photo_path
    json.slug user.batch.slug if user.batch
    json.city user.batch.city.name if user.batch
  end
end
