json.projects @projects.each do |project|
  if project
    json.extract! project, :id, :url, :name, :position, :slug
    json.tagline do
      json.en project.tagline_en
      json.fr project.tagline_fr
    end
    json.thumbnail project.cover_picture.url(:thumbnail)
    json.card project.cover_picture.url(:card)
    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, :id, :github_nickname
        json.thumbnail user.thumbnail(width: 35, height: 35, crop: :fill)
      end
    end
    if project.batch
      json.batch project.batch.slug
      json.city do
        json.extract! project.batch.city, :name, :slug
      end
    end
  end
end
