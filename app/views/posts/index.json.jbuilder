json.resources do
  json.partial! "index", posts: @resources
end

json.questions do
  json.partial! "index", posts: @questions
end

json.jobs do
  json.partial! "index", posts: @jobs
end

json.milestones do
  json.partial! "index", posts: @milestones
end

json.current_user do
  json.can_post user_signed_in?
  json.can_post_milestone user_signed_in? ? current_user.projects.any? : false
end
