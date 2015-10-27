json.stories do
  json.array! @stories do |story|
    json.id story.id
    json.company do
      json.name story.company.name if story.company
      json.logo story.company.logo.url(:thumbnail) if story.company
    end
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
