json.extract! @user, :id, :github_nickname, :gravatar_url, :slack_uid

json.connected_to_slack @user.connected_to_slack?
json.user_messages_slack_url @user.user_messages_slack_url
