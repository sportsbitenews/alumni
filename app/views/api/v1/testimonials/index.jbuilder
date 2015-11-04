json.array! @testimonials.each do |testimonial|
  json.extract! testimonial, :id, :content, :locale
  json.user do
    json.extract! testimonial.user, :github_nickname, :gravatar_url, :first_name, :last_name
    json.batch do
      json.extract! testimonial.user.batch, :slug
      json.city do
        json.extract! testimonial.user.batch.city, :name
      end
    end
  end
end
