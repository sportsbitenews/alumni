json.extract! @user, :github_nickname, :email, :first_name, :last_name
json.hide_public_profile @user.noindex
json.avatar_url cloudinary_url(@user.photo_path)
json.slack_alumni_uid @user.slack_uid
