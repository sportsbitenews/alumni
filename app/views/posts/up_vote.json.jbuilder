type = @post.class.to_s.underscore
json.partial! "#{type.pluralize}/#{type}", { type.to_sym => @post }
json.answers do
  json.array! @post.answers.each do |answer|
    json.partial! "answers/answer", answer: answer
  end
end

json.answerers do
  json.array! @post.answers.map do |answer|
    json.extract! answer.user, :id, :gravatar_url, :github_nickname
    json.connected_to_slack answer.user.connected_to_slack
  end
end
