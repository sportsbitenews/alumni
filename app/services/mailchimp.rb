class Mailchimp
  def initialize
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_ALUMNI_LIST_ID']
  end

  def subscribe_to_alumni_list(user)
    @gibbon.lists(@list_id).members(Digest::MD5.hexdigest(user.email)).upsert(
      body: {
        email_address: user.email,
        status: "subscribed",
        merge_fields: {
          FNAME:  user.first_name,
          LNAME:  user.last_name,
          BATCH:  user.batch.slug,
          GITHUB: user.github_nickname,
          CITY:   user.batch.city.slug
        }
      }
    )
  end
end
