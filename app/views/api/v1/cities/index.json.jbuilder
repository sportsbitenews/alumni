json.cities do
  json.array! @cities do |city|
    json.extract! city, :id, :name, :slug, :location
    json.description do
      json.fr city.description_fr
      json.en city.description_en
    end
    json.extract! city, :address, :latitude, :longitude
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
    json.extract! city, :meetup_id, :twitter_url
    json.batches city.open_batches do |batch|
      json.extract! batch, :id, :starts_at, :ends_at, :full, :last_seats, :price_cents, :price_currency
    end
  end
end
