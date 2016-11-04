json.batch do
  json.extract! batch, :id, :trello_inbox_list_id, :price_cents, :price_currency
end
