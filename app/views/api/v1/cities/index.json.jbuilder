json.cities do
  json.array! @cities do |city|
    json.extract! city, :id, :name, :slug, :location
    json.description do
      json.fr city.description_fr
      json.en city.description_en
    end
    json.extract! city, :address, :latitude, :longitude
    json.location_picture city.location_picture.url(:cover)
    json.city_picture city.city_picture.url(:cover)
    json.extract! city, :meetup_id, :twitter_url
    json.next_batch do
      json.extract! @city.next_available_batch, :starts_at, :ends_at, :last_seats
    end
  end
end
