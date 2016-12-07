class MeetupClientCache
  include Cache

  def meetup_url(meetup_id)
    return "" if meetup_id.blank?
    from_cache(:meetup_url, meetup_id, expire: 30.days) do
      groups = MeetupApi.new.groups(group_id: meetup_id)["results"]
      if groups && groups.first
        groups.first['link']
      else
        ""
      end
    end
  rescue Exception => e
    puts e
    puts "Could not fetch infor about meetup #{meetup_id}"
    ""
  end
end
