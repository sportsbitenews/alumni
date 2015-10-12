json.projects @projects.each do |project|
  if project
    json.extract! project, :id, :url, :name, :tagline, :position, :slug
    json.thumbnail project.cover_picture.url(:thumbnail)
    json.card project.cover_picture.url(:card)
    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, :id, :github_nickname, :thumbnail
      end
    end
    json.batch project.batch.slug
    json.city do
      json.extract! project.batch.city, :name, :slug
    end
  end
end
