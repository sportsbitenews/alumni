require "pathname"

namespace :api do
  task :upload_pictures, [:folder] => :environment do |t, args|
    # endpoint = "http://localhost:3000/api/v1/users/picture"
    endpoint = "http://alumni.lewagon.org/api/v1/users/picture"

    Dir["#{args[:folder]}/*.jpg"].each do |file|
      puts file
      params = {
        filename: Pathname.new(file.to_s).basename.to_s,
        content: Base64.encode64(File.open(file).read)
      }

      puts RestClient.put endpoint, params, content_type: :json, accept: :json, \
        'Authorization': ENV['ALUMNI_PICTURE_UPLOADER_SCRIPT_SHARED_SECRET']
    end
  end
end
