if @user
  json.errors false
  json.error_content ''
else
  json.errors true
  json.error_content @github_nickname + ' is not a valid GitHub nickname'
end
if @role == 'teacher_assistant'
  json.members do
    json.array! @teacher_assistants do |ta|
      json.full_name ta.first_name + ' ' + ta.last_name
      json.github_nickname ta.github_nickname
      json.gravatar_url ta.gravatar_url
    end
  end
elsif @role == 'teacher'
  json.members do
    json.array! @teachers do |teacher|
      json.full_name teacher.first_name + ' ' + teacher.last_name
      json.bio_en teacher.bio_en
      json.bio_fr teacher.bio_fr
      json.role teacher.role
      json.github_nickname teacher.github_nickname
      json.twitter_nickname teacher.twitter_nickname
      json.gravatar_url teacher.gravatar_url
    end
  end
end
