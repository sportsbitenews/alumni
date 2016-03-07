json.slug @batch.slug
json.starts_at @batch.starts_at.strftime('%B ')
json.ends_at @batch.ends_at.strftime('%B %Y')
json.city @batch.city.name
json.live @batch.live
json.youtube_id @batch.youtube_id
json.cover_image @cover_image

json.students do
  json.array! @batch.users.sort_by(&:sidebar_order).each do |user|
    json.extract! user, :first_name, :last_name, :github_nickname, :thumbnail, :connected_to_slack
  end
end

json.projects do
  json.array! @batch.projects.each do |project|
    json.extract! project, :name, :url, :id
    json.tagline_en project.tagline_en
    json.thumbnail_url project.cover_picture.url(:thumbnail)

    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, *user_properties
      end
    end
    json.milestones do
      json.array! project.milestones.each do |milestone|
        json.partial! 'milestones/milestone', milestone: milestone
      end
    end
  end
end
