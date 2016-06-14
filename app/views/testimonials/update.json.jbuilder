json.partial! 'cities/testimonials'
if !@user
  json.errors true
  json.error_content "'" + @github_nickname +"' is not a valid GitHub nickname"
end
