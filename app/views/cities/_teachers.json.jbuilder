json.teachers do
  json.array! @teachers do |teacher|
    json.full_name teacher.first_name + ' ' + teacher.last_name
    json.bio_en teacher.bio_en
    json.bio_fr teacher.bio_fr
    json.role teacher.role
    json.github_nickname teacher.github_nickname
    json.twitter_nickname teacher.twitter_nickname
    json.gravatar_url teacher.gravatar_url
    json.city @city.slug
  end
end
