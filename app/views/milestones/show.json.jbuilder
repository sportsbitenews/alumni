json.partial! "milestones/milestone", milestone: @milestone
json.partial! 'answers/index', answers: @milestone.answers

json.answerers do
  json.array! @milestone.answers.each do |milestone|
    json.extract! milestone.user, :id, :gravatar_url, :github_nickname
    json.connected_to_slack milestone.user.connected_to_slack?
  end
end
