json.teachers do
  json.array! @teachers do |teacher|
    json.full_name teacher.first_name + ' ' + teacher.last_name
    json.bio_en teacher.bio_en
    json.bio_fr teacher.bio_fr
    json.role teacher.role
    json.github_nickname teacher.github_nickname
    json.twitter_nickname teacher.twitter_nickname
    json.gravatar_url teacher.gravatar_url
  end
end
json.tas do
  json.array! @teacher_assistants do |ta|
    json.full_name ta.first_name + ' ' + ta.last_name
    json.github_nickname ta.github_nickname
    json.gravatar_url ta.gravatar_url
  end
end
json.city do
  json.name @city.name
  json.slug @city.slug
end
