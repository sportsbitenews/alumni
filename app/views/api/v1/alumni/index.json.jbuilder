json.alumni @alumni.each do |alumnus|
  json.extract! alumnus, :id, :github_nickname, :gravatar_url, :first_name, :last_name
  json.city do
    json.extract! alumnus.batch.city, :name, :slug
  end
  json.batch_slug alumnus.batch.slug
end
