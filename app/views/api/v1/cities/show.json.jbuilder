json.city do
  json.extract! @city, :id, :name, :slug, :location, :specifics, :course_locale
  json.description do
    json.fr @city.description_fr
    json.en @city.description_en
  end
  json.extract! @city, :address, :latitude, :longitude
  json.location_picture @city.location_picture.present? ? @city.location_picture.url(:cover) : nil
  json.city_picture @city.city_picture.present? ? @city.city_picture.url(:cover) : nil
  json.classroom_picture @city.classroom_picture.present? ? @city.classroom_picture.url(:cover) : nil
  json.extract! @city, :meetup_id, :twitter_url
  json.teachers @teachers do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :thumbnail, :first_name, :last_name
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
  end
  json.teacher_assistants @teacher_assistants do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :thumbnail, :first_name, :last_name
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
  end
end
