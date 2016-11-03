json.batches do
  json.array! @batches do |batch|
    json.batch do
      json.slug batch.slug
      json.city batch.city.name
    end
  end
end

