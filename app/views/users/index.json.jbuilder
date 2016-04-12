json.users do
  json.array! @users do |user|
    json.partial! 'user', user: user
    if user.post_wagon_experiences.nil?
      json.position do
        json.title "Alumni"
        json.company "Le Wagon"
        json.url "lewagon.com"
      end
    else
      json.position do
        json.title user.post_wagon_experiences.first['title']
        unless user.post_wagon_experiences.first['title'] == 'Freelance'
          json.company user.post_wagon_experiences.first['name']
          if user.post_wagon_experiences.first['url'].present?
            json.url user.post_wagon_experiences.first['url']
          else
            json.url "#{user.post_wagon_experiences.first['name'].downcase.delete(' ')}.com"
          end
        end
      end
    end
  end
end
