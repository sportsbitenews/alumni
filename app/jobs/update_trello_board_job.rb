class UpdateTrelloBoardJob < ActiveJob::Base
  def perform(batch_id)
    batch = Batch.find(batch_id)

    payload = {
      batch: batch.as_json(only: %i(starts_at))
    }

    response = JSON.parse(
      RestClient.put url(batch.trello_inbox_list_id), payload.to_json,
        content_type: :json,
        :'X-CRM-TOKEN' => ENV['CRM_TOKEN']
    )

    batch.trello_inbox_list_id = response["inbox_list_id"]
    batch.save!
  end

  private

  def url(trello_inbox_list_id)
    "#{ENV['CRM_BASE_URL']}/api/v1/boards/#{trello_inbox_list_id}"
  end
end
