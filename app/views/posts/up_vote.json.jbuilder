type = @post.class.to_s.underscore
json.partial! "#{type.pluralize}/#{type}", { type.to_sym => @post }
json.answers do
  json.array! @post.answers.each do |answer|
    json.partial! "answers/answer", answer: answer
  end
end
json.answerers do
  json.array! @post.answers.map do |post|
    json.extract! post.user, :id, :gravatar_url, :github_nickname
  end
end
