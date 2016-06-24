json.testimonials do
  json.array! @testimonials do |testimonial|
    json.id testimonial.id
    json.content testimonial.content
    json.locale testimonial.locale
    json.user do
      json.slug testimonial.user.github_nickname
      json.full_name testimonial.user.name
      json.thumbnail testimonial.user.thumbnail
      json.batch testimonial.user.batch.slug
      json.city testimonial.user.batch.city.name
    end
  end
end
json.alumnus_default_picture image_url('octowagon.png')
json.city_slug @city.slug
if @error_content
  json.errors true
  json.error_content @error_content
end
