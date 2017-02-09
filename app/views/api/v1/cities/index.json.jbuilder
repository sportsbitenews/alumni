json.cities do
  json.array! @cities do |city|
    json.extract! city, :id, :name, :slug, :location, :apply_facebook_pixel
    json.description do
      json.fr city.description_fr
      json.en city.description_en
    end

    json.extract! city, :address, :latitude, :longitude, :course_locale, :twitter_url
    json.city_background_picture_path city.city_background_picture.try(:path)
    json.location_background_picture_path city.location_background_picture.try(:path)
    json.classroom_background_picture_path city.classroom_background_picture.try(:path)

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
