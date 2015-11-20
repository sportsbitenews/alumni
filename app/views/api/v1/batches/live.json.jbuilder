json.batch do
  json.live_url @live_url
  json.extract! @batch, :slug
  json.city @batch.city.name
  json.projects_count @batch.projects.count
end
