json.batch do
  json.live !@batch.nil?
  if @batch
    json.live_url batch_url(@batch.slug)
    json.extract! @batch, :slug
    json.city @batch.city.name if @batch.city
    json.projects_count @batch.projects.count
  end
end
