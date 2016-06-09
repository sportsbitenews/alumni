if @error_content == ''
  json.errors false
  json.error_content ''
else
  json.errors true
  json.error_content @error_content
end
json.partial! 'cities/members', members: @members, ordered_list: @ordered_list, position: @position

