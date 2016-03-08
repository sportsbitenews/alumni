class PushUserToKittJob < ActiveJob::Base
  def perform(user_id)
    user = User.find(user_id)

    new_student_url = "#{ENV['KITT_BASE_URL']}/api/v1/alumni/student"
    client = RestClient::Resource.new(new_student_url, user: 'alumni', password: ENV['ALUMNI_PASSWORD'])
    payload = {
      camp: {
        slug: user.batch.slug
      },
      user: user.slice(:github_nickname, :uid, :email, :first_name, :last_name, :gravatar_url, :phone, :private_bio)
    }
    client.post(payload.to_json, content_type: :json)
  end
end
