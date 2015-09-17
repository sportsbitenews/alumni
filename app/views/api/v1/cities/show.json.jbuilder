json.city do
  json.id @city.id
  json.name @city.name
  json.location @city.location
  json.description do
    json.fr @city.description_fr
    json.en @city.description_en
  end
  json.address @city.address
  json.latitude @city.latitude
  json.longitude @city.longitude
  json.location_picture @city.location_picture.url(:big)
  json.city_picture @city.city_picture.url(:big)
  json.meetup_id @city.meetup_id
  json.twitter_url @city.twitter_url
  json.next_batch do
    json.slug @city.next_available_batch.slug
    json.starts_at @city.next_available_batch.starts_at
    json.ends_at @city.next_available_batch.starts_at
    json.last_seats @city.next_available_batch.last_seats
    json.teachers @city.next_available_batch.teachers do |teacher|
      json.id teacher.id
      json.github_nickname teacher.github_nickname
      json.gravatar_url teacher.gravatar_url
      json.first_name teacher.first_name
      json.last_name teacher.last_name
      json.teacher_assistant teacher.teacher_assistant
      json.teacher teacher.teacher
    end
  end
end
