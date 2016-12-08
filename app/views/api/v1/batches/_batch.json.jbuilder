json.extract! batch, :id, :slug, :starts_at, :ends_at, :full, :last_seats, :waiting_list, :price_cents, :price_currency, :trello_inbox_list_id, :youtube_id
json.cover_image batch.cover_image.url(:large)

json.meta_image do
  json.facebook @batch.meta_image.exists? ? @batch.meta_image.url(:facebook) : nil
end

json.city do
  json.name batch.city.name
  json.slug batch.city.slug
  json.course_locale batch.city.course_locale
end
json.analytics_slug "#{batch.city.name.downcase.gsub(/\s/, '')}-#{batch.starts_at.strftime("%B").downcase}-#{batch.starts_at.strftime("%Y")}"
json.students do
  json.array! batch.users.sort.each do |user|
    json.first_name user.first_name.capitalize
    json.last_name user.last_name.capitalize
    json.thumbnail user.thumbnail(width: 180, height: 180, crop: :fill)
  end
end
json.products do
  json.array! batch.projects.each do |project|
    json.extract! project, :name, :url, :id, :slug, :tagline_en, :demoday_timestamp
    json.technos project.technos.sort
    json.batch_language project.batch.city.course_locale
    json.cover_url project.cover_picture.url(:cover)
    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, :id, :first_name, :last_name
        json.thumbnail user.thumbnail(width: 84, height: 84, crop: :fill)
      end
    end
  end
end
