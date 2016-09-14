json.extract! answer, :id, :answerable_id, :answerable_type
json.content render_markdown(enriched_content(answer.content))
json.original_content answer.content.gsub(/\r\n/, "\n")
json.time_ago time_ago_in_words(answer.created_at)
json.editable policy(answer).update?
json.user do
  json.extract! answer.user, :id, :github_nickname
  json.thumbnail answer.user.thumbnail(width: 50, height: 50, gravity: :face, crop: :thumb)
  json.connected_to_slack answer.user.connected_to_slack
end
