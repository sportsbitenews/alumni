json.alumni @alumni.each do |alumnus|
  json.extract! alumnus, :id, :github_nickname, :gravatar_url, :first_name, :last_name
end
