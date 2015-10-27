class InvalidateWwwCacheJob < ActiveJob::Base
  def perform
    RestClient.delete("http://www.lewagon.com/cache", {
      'Authorization': ENV['ALUMNI_WWW_SHARED_SECRET']
    })
  end
end
