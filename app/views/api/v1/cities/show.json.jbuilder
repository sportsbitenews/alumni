json.city do
  json.extract! @city, :id, :name, :email, :slug, :location, :logistic_specifics, :marketing_specifics, :course_locale, :apply_facebook_pixel, :mailchimp_list_id, :encrypted_mailchimp_api_key, :contact_phone_number, :contact_phone_number_displayed, :contact_phone_number_name, :meetup_id, :address, :latitude, :longitude, :twitter_url
  json.description do
    json.fr @city.description_fr
    json.en @city.description_en
  end
  json.city_background_picture_path @city.city_background_picture.try(:path)
  json.location_background_picture_path @city.location_background_picture.try(:path)
  json.classroom_background_picture_path @city.classroom_background_picture.try(:path)
  if @city.meetup_id
    json.meetup_url @meetup_client.meetup_url(@city.meetup_id)
  end
  json.teachers @teachers do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :first_name, :last_name, :photo_path
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
  end
  json.teacher_assistants @teacher_assistants do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :first_name, :last_name, :photo_path
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
  end
end
