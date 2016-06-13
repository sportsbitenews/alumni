class CreateTrelloBoard < ActiveJob::Base
  def perform(batch_id)
    batch = Batch.find(batch_id)

    payload = {
      city: {
        slug: batch.city.slug
      },
      batch: {
        starts_at: batch.starts_at
      }
    }

    response = JSON.parse(
      RestClient.post url, payload.to_json,
        content_type: :json,
        :'X-CRM-TOKEN' => ENV['CRM_TOKEN']
    )

    batch.trello_inbox_list_id = response["inbox_list_id"]
    batch.save!
  end

  private

  def url
    "#{ENV['CRM_BASE_URL']}/api/v1/boards"
  end
end
