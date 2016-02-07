class Api::V1::BaseController < ActionController::Base
  http_basic_authenticate_with name: "lewagon", password: ENV['ALUMNI_WWW_SHARED_SECRET']
end
