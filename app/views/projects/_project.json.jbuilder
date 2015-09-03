json.name project.name
json.url project.url
json.id project.id
json.tagline project.tagline

json.makers do
  json.array! project.users.each do |maker|
    json.extract! maker, *user_properties
  end
end

json.batch do
  json.city @project.batch.city.name
  json.slug @project.batch.slug
  json.id @project.batch.id
end

json.milestones do
  json.array! project.milestones.reverse do |milestone|
    json.partial! 'milestones/milestone', milestone: milestone
  end
end
