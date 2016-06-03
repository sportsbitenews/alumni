json.managers do
  json.array! @managers do |manager|
    json.github_nickname manager.github_nickname
    json.gravatar_url manager.gravatar_url
    json.city @city.slug
  end
end
json.city_slug @city.slug
