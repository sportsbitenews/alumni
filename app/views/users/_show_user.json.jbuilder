json.partial! 'user', user: user
json.current_user do
  json.user_signed_in user_signed_in?
  json.github_nickname current_user.github_nickname
  json.manager current_user.cities.include?(user.batch.city)
  json.admin current_user.admin
end
