json.extract! answer, :id
json.content render_markdown(answer.content)
json.user do
  json.extract! answer.user, :id, :gravatar_url, :github_nickname
end
