json.groups do
  json.array! @groups do |group|
    group_ordered_list = OrderedList.find_by(name: "#{group.slug}_cities")
    json.group group.name
    json.icon group.icon
    json.cities do
      json.array! group.cities.where(slug: group_ordered_list.slugs).sort_by { |c| group_ordered_list.slugs.index(c.slug) } do |city|
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
          json.extract! city, :meetup_id
          json.meetup_url @meetup_client.meetup_url(city.meetup_id)
        end
        json.batches city.open_batches do |batch|
          json.extract! batch, :id, :starts_at, :ends_at, :full, :last_seats, :waiting_list, :price_cents, :price_currency, :force_completed_codecademy_at_apply
          json.analytics_slug "#{batch.city.name.downcase.gsub(/\s/, '')}-#{batch.starts_at.strftime("%B").downcase}-#{batch.starts_at.strftime("%Y")}"
        end
      end
    end
  end
end
