json.partial! 'user', user: user
json.current_user do
  json.user_signed_in user_signed_in?
  json.github_nickname current_user.github_nickname
end
