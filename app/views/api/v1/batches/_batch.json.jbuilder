json.extract! batch, :id, :starts_at, :ends_at, :full, :last_seats, :waiting_list, :price_cents, :price_currency, :trello_inbox_list_id, :youtube_id
json.city do
  json.name batch.city.name
  json.slug batch.city.slug
  json.course_locale batch.city.course_locale
end
json.schedule_slug "#{batch.starts_at.strftime("%B").camelcase} - #{batch.ends_at.strftime("%B %Y").camelcase}"
json.analytics_slug "#{batch.city.name.downcase.gsub(/\s/, '')}-#{batch.starts_at.strftime("%B").downcase}-#{batch.starts_at.strftime("%Y")}"
json.students do
  json.array! @batch.users.sort.each do |user|
    json.first_name user.first_name.capitalize
    json.last_name user.last_name.capitalize
    json.thumbnail user.thumbnail(width: 180, height: 180, crop: :fill)
  end
end
json.products do
  json.array! @batch.projects.each do |project|
    json.extract! project, :name, :url, :id, :tagline_en
    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, :id, :first_name, :last_name
        json.thumbnail user.thumbnail(width: 42, height: 42, crop: :fill)
      end
    end
  end
end
