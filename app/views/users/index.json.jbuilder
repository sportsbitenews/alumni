json.users do
  json.array! @users do |user|
    json.partial! 'user', user: user
    json.position user.position
  end
end
json.algolia_application_id ENV['ALGOLIA_APPLICATION_ID']
json.algolia_search_only_api_key "0b73f9c31bbddd46c23022b339086f97"
