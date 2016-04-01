json.users do
  json.array! @users do |user|
    json.partial! 'user', user: user
    json.position user.position
    if user.position[:title] == 'Freelance'
      json.position_url letter_avatar_url("Freelance".downcase, 200)
    else
      json.position_url user.position[:company].downcase.delete(' ')
      json.position_alt_url letter_avatar_url(user.position[:company].downcase, 200)
    end
  end
end
json.algolia_application_id ENV['ALGOLIA_APPLICATION_ID']
json.algolia_search_only_api_key "0b73f9c31bbddd46c23022b339086f97"
