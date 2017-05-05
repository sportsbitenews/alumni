class Mailchimp
  def initialize(attributes = {})
    @api_key = attributes.keys.include?(:mailchimp_api_key) ? attributes[:mailchimp_api_key] : ENV['MAILCHIMP_API_KEY']
    @gibbon = Gibbon::Request.new(api_key: @api_key)
    @list_id = attributes.keys.include?(:mailchimp_list_id) ? attributes[:mailchimp_list_id] : ENV['MAILCHIMP_ALUMNI_LIST_ID']
  end

  def count_subscribers
    @gibbon.lists(@list_id).retrieve["stats"]["member_count"]
  end
end
