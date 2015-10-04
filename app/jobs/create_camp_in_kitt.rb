class CreateCampInKitt < ActiveJob::Base
  def perform(batch_id)
    batch = Batch.find(batch_id)

    new_camp_url = "#{ENV['KITT_BASE_URL']}/api/v1/alumni/camp"
    client = RestClient::Resource.new(new_camp_url, user: 'alumni', password: ENV['ALUMNI_PASSWORD'])
    payload = {
      camp: {
        slug: batch.slug,
        starts_at: batch.starts_at,
        time_zone: batch.time_zone,
        city: batch.city.name
      }
    }
    client.post(payload.to_json, content_type: :json)
  end
end
