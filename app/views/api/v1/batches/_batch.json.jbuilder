json.extract! batch, :id, :starts_at, :ends_at, :full, :last_seats, :waiting_list, :price_cents, :price_currency, :trello_inbox_list_id
json.analytics_slug "#{batch.city.name.downcase.gsub(/\s/, '')}-#{batch.starts_at.strftime("%B").downcase}-#{batch.starts_at.strftime("%Y")}"
json.students do
  json.array! @batch.users.each do |user|
    json.extract! user, :first_name, :last_name
    json.thumbnail user.thumbnail(width: 90, height: 90, crop: :fill)
  end
end
json.products do
  json.array! @batch.projects.each do |project|
    json.extract! project, :name, :url, :id
    json.makers do
      json.array! project.users.each do |user|
        json.extract! user, :id, :first_name, :last_name
        json.thumbnail user.thumbnail(width: 42, height: 42, crop: :fill)
      end
    end
  end
end
