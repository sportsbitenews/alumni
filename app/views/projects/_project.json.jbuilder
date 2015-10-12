json.name project.name
json.url project.url
json.id project.id
json.tagline project.tagline
json.cover_url project.cover_picture.url(:cover)
json.thumbnail_url project.cover_picture.url(:thumbnail)

json.makers do
  json.array! project.users.each do |maker|
    json.extract! maker, *user_properties
  end
end

if @project.batch
  json.batch do
    json.city @project.batch.city.name
    json.slug @project.batch.slug
    json.id @project.batch.id
  end
end

json.milestones do
  json.array! project.milestones.reverse do |milestone|
    json.partial! 'milestones/milestone', milestone: milestone
  end
end
