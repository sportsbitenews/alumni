json.thumbnail @user.thumbnail(width: 180, height: 180, crop: :fill)
json.error_message @error_message.nil? ? '' : @error_message
