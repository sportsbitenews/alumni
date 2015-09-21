json.city do
  json.extract! @city, :id, :name, :slug, :location
  json.description do
    json.fr @city.description_fr
    json.en @city.description_en
  end
  json.extract! @city, :address, :latitude, :longitude
  json.location_picture @city.location_picture.url(:cover)
  json.city_picture @city.city_picture.url(:cover)
  json.extract! @city, :meetup_id, :twitter_url
  json.next_batch do
    json.extract! @city.next_available_batch, :slug, :starts_at, :ends_at, :last_seats
    json.teachers @teachers do |teacher|
      json.extract! teacher, :id, :github_nickname, :thumbnail, :first_name, :last_name
      json.bio do
        json.fr teacher.bio_fr
        json.en teacher.bio_en
      end
    end
    json.teacher_assistants @teacher_assistants do |teacher|
      json.extract! teacher, :id, :github_nickname, :thumbnail, :first_name, :last_name
      json.bio do
        json.fr teacher.bio_fr
        json.en teacher.bio_en
      end
    end
  end
end
