json.array! @users do |user|
  # React Mentions needs id & display
  json.id user.github_nickname
  json.display "@#{user.github_nickname} - #{user.name}"
end
