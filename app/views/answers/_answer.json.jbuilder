json.extract! answer, :id, :content
json.user do
  json.extract! answer.user, :id, :gravatar_url, :github_nickname
end