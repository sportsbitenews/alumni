json.batches do
  json.array! @batches do |batch|
    json.extract! batch, :id, :slug, :starts_at, :ends_at, :youtube_id
    json.city do
      json.name batch.city.name
      json.slug batch.city.slug
      json.course_locale batch.city.course_locale
      json.city_background_picture_path batch.city.city_background_picture.try(:path)
    end
    json.student_count batch.users.size
    json.project_count batch.projects.size
  end
end
