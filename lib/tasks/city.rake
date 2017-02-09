namespace :city do
  task migrate_pictures: :environment do
    City.all.each do |city|
      city.city_background_picture_url = city.city_picture.url if city.city_picture.file?
      city.location_background_picture_url = city.location_picture.url if city.location_picture.file?
      city.classroom_background_picture_url = city.classroom_picture.url if city.classroom_picture.file?
      city.save
    end
  end
end
