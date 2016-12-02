json.partial! 'user', user: user

json.current_user do
  json.user_signed_in user_signed_in?
  if current_user
    json.can_update_photo policy(user).update_photo?
  else
    json.can_update_photo false
  end
end
