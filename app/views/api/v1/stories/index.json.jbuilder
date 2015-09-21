json.stories do
  json.array! @stories do |story|
    json.id story.id
    json.description do
      json.fr story.description_fr
      json.en story.description_en
    end
    json.picture story.picture.url(:cover)
    json.alumni do
      json.extract! story.user, :id, :github_nickname, :thumbnail, :first_name, :last_name
      json.slug story.user.batch.slug if story.user.batch
      json.city story.user.batch.city.name if story.user.batch
    end
  end
end
