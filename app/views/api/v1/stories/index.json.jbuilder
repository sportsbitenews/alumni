json.stories do
  json.array! @stories do |story|
    json.id story.id
    json.id story.id
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
    json.alumni do
      json.extract! story.user, :id, :github_nickname, :thumbnail, :first_name, :last_name
      json.slug story.user.batch.slug if story.user.batch
      json.city story.user.batch.city.name if story.user.batch
    end
  end
end
