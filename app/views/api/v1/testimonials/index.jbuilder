  @testimonials.each do |testimonial|
    json.extract! testimonial, :content
    json.user do
      json.from_batch testimonial.user.batch.slug
      json.from_city testimonial.user.batch.city.name
      json.extract! testimonial.user, :github_nickname, :gravatar_url, :first_name, :last_name
    end
  end

