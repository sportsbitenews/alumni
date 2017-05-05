json.id story.id
json.slug story.slug
json.created_at story.created_at

if story.company
  json.company do
    json.name story.company.name
    json.url story.company.url
    json.logo story.company.logo.url(:thumbnail)
  end
end
json.title do
  json.fr story.title_fr
  json.en story.title_en
end
json.summary do
  json.fr story.summary_fr
  json.en story.summary_en
end
json.description do
  json.fr story.description_fr
  json.en story.description_en
end
json.picture story.picture.url(:cover)

user = User.includes(:batch).find(story.user_id)

json.alumni do
  json.extract!user , :id, :github_nickname, :first_name, :last_name, :photo_path
  json.slug user.batch.slug if user.batch
  json.city user.batch.city.name if user.batch
end

