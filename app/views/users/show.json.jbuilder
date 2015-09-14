json.partial! 'user', user: @user
json.current_user do
  json.user_signed_in user_signed_in?
end
