json.answers do
  json.array! answers.map do |answer|
    json.extract! answer, :id, :content
    json.content render_markdown(answer.content)
    json.user do
      json.extract! answer.user, :id, :github_nickname, :gravatar_url
    end
  end
end