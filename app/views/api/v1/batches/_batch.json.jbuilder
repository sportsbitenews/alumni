json.extract! batch, :id, :starts_at, :ends_at, :full, :last_seats, :waiting_list, :price_cents, :price_currency, :trello_inbox_list_id
json.analytics_slug "#{batch.city.name.downcase.gsub(/\s/, '')}-#{batch.starts_at.strftime("%B").downcase}-#{batch.starts_at.strftime("%Y")}"
