json.partial! "resources/resource", resource: @resource
json.partial! 'answers/index', answers: @resource.answers
json.answerers do
  json.array! @resource.answers.each do |answer|
    json.extract! answer.user, :id, :gravatar_url, :github_nickname
  end
end
