json.partial! "project", project: @project
json.batch do
  json.city @project.batch.city.name
  json.name @project.batch.name
end
