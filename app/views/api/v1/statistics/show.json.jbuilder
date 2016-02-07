json.alumni do
  json.total @alumni_count
  json.cities @alumni_cities
end

json.batches do
  json.total @batches_count
  json.cities @batches_cities
end
