class Api::V1::AlumniController < Api::V1::BaseController
  before_action :set_city
  def index
    @alumni = @city.users
  end
  private
  def set_city
    @city = City.friendly.find(params[:city_id])
  end
end
