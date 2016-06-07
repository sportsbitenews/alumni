json.teaching_assistants do
  json.array! @teacher_assistants do |ta|
    json.full_name ta.first_name + ' ' + ta.last_name
    json.github_nickname ta.github_nickname
    json.gravatar_url ta.gravatar_url
    json.city @city.slug
  end
end
