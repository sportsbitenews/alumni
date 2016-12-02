json.partial! 'show_user', user: @user
json.error_message @error_message.nil? ? '' : @error_message
