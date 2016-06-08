if @user
  json.errors false
  json.error_content ''
else
  json.errors true
  json.error_content @github_nickname + ' is not a valid GitHub nickname'
end
json.partial! 'cities/members', members: @members, ordered_list: @ordered_list, position: @position

