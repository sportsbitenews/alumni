json.alumni @alumni.each do |alumnus|
  json.extract! alumnus, :thumbnail
end
