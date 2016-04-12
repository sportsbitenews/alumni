json.partial! 'user', user: @user
json.mood @user.mood
json.current_user do
  json.github_nickname current_user.github_nickname
  json.user_signed_in user_signed_in?
  json.id current_user.id
end
