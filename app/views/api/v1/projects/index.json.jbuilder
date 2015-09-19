json.projects @projects.each do |project|
  json.extract! project, :id, :url, :batch_id, :tagline, :position
  json.thumbnail project.cover_picture.url(:thumbnail)
  json.makers do
    json.array! project.users.each do |user|
      json.extract! user, :id, :github_nickname, :gravatar_url, :first_name, :last_name
    end
  end
end
