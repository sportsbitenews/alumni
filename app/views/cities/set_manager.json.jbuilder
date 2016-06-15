if @user
  json.errors false
  json.error_content ''
else
  json.errors true
  json.error_content '"' + @github_nickname + '" is not a valid member of alumni.lewagon.org.'
end
json.managers do
  json.array! @managers do |manager|
    json.github_nickname manager.github_nickname
    json.gravatar_url manager.gravatar_url
    json.city @city.slug
  end
end
