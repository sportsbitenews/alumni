json.resources do
  json.array! @posts[:resources] do |resource|
    json.partial! "resources/resource", resource: resource
  end
end

json.questions do
  json.array! @posts[:questions] do |question|
    json.partial! "questions/question", question: question
  end
end

json.jobs do
  json.array! @posts[:jobs] do |job|
    json.partial! "jobs/job", job: job
  end
end

json.milestones do
  json.array! @posts[:milestones] do |milestone|
    json.partial! "milestones/milestone", milestone: milestone
  end
end

json.current_user do
  json.can_post user_signed_in?
  json.can_post_milestone user_signed_in? ? current_user.projects.any? : false
end
