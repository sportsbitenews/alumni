json.extract! answer, :id, :answerable_id, :answerable_type
json.content render_markdown(answer.content)
json.time_ago time_ago_in_words(answer.created_at)

json.user do
  json.extract! answer.user, :id, :gravatar_url, :github_nickname
end

