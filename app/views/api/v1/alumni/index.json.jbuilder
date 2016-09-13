json.alumni @alumni.each do |alumnus|
  json.extract! alumnus, :photo_path
end
