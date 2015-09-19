json.teachers @teachers.each do |teacher|
  json.extract! teacher, :id, :github_nickname, :gravatar_url, :first_name, :last_name
end
