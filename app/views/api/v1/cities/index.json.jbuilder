json.cities do
  json.array! @cities do |city|
    json.id city.id
    json.name city.name
    json.location city.location
    json.description do
      json.fr city.description_fr
      json.en city.description_en
    end
    json.address city.address
    json.latitude city.latitude
    json.longitude city.longitude
    json.location_picture city.location_picture.url(:big)
    json.city_picture city.city_picture.url(:big)
    json.meetup_id city.meetup_id
    json.twitter_url city.twitter_url
  end
end
