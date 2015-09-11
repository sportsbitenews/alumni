json.slug @batch.slug
json.starts_at @batch.starts_at.strftime('%B ')
json.ends_at @batch.ends_at.strftime('%B %Y')
json.city @batch.city.name
json.live @batch.live
json.youtube_id @batch.youtube_id

json.students do
  json.array! @batch.users.each do |user|
    json.extract! user, :github_nickname, :gravatar_url
  end
end

json.projects do
  json.array! @batch.projects.each do |project|
    json.extract! project, :name, :url, :tagline, :id
    json.thumbnail_url project.cover_picture.url(:thumbnail)

    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, *user_properties
        json.connected_to_slack user.connected_to_slack
      end
    end

    json.milestones do
      json.array! project.milestones.each do |milestone|
        json.partial! 'milestones/milestone', milestone: milestone
      end
    end
  end
end
