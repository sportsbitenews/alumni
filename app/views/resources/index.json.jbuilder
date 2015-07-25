json.resources do
  json.array! @resources do |resource|
    json.extract! resource, :id, :title
  end
end
