json.testimonials do
  json.array! @testimonials do |testimonial|
    json.id testimonial.id
    json.content testimonial.content
    json.locale testimonial.locale
    json.user do
      json.slug testimonial.user.github_nickname
      json.full_name testimonial.user.first_name + ' ' + testimonial.user.last_name
      json.batch testimonial.user.batch.slug
      json.city testimonial.user.batch.city.name
    end
  end
end
json.city_slug @city.slug
