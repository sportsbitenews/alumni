json.cities do
  json.array! @cities do |city|
    json.extract! city, :id, :name, :slug, :location, :apply_facebook_pixel
    json.description do
      json.fr city.description_fr
      json.en city.description_en
    end
    json.extract! city, :address, :latitude, :longitude, :course_locale
    json.pictures do
      json.city do
        json.cover city.city_picture.url(:cover)
        json.thumbnail city.city_picture.url(:thumbnail)
      end
      json.location do
        json.cover city.location_picture.url(:cover)
        json.thumbnail city.location_picture.url(:thumbnail)
      end
    end
    json.extract! city, :twitter_url
    if city.meetup_id
      groups = @meetup_client.groups(group_id: city.meetup_id)["results"]

      if groups && !groups.empty?
        json.extract! city, :meetup_id
        json.meetup_url groups.first['link']
      end
    end
    json.batches city.open_batches do |batch|
      json.partial! 'api/v1/batches/batch', batch: batch
    end
  end
end
