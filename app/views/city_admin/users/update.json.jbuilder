json.member do
  json.full_name @user.first_name + ' ' + @user.last_name
  json.bio_en @user.bio_en
  json.bio_fr @user.bio_fr
  json.role @user.role
  json.github_nickname @user.github_nickname
  json.twitter_nickname @user.twitter_nickname
  json.thumbnail @user.thumbnail(width: 42, height: 42, crop: :fill)
  json.photo_path @user.photo_path
  json.ordered_list_id @ordered_list_id
end
