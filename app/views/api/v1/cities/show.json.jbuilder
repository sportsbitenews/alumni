json.city do
  json.extract! @city, :id, :name, :location
  json.description do
    json.fr @city.description_fr
    json.en @city.description_en
  end
  json.extract! @city, :address, :latitude, :longitude
  json.location_picture @city.location_picture.url(:big)
  json.city_picture @city.city_picture.url(:big)
  json.extract! @city, :meetup_id, :twitter_url
  json.next_batch do
    json.extract! @city.next_available_batch, :slug, :starts_at, :ends_at, :last_seats
    json.teachers @city.next_available_batch.teachers do |teacher|
      json.extract! teacher, :id, :github_nickname, :gravatar_url, :first_name,
                             :last_name, :teacher_assistant, :teacher
    end
  end
end
