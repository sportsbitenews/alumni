class Api::V1::TeachersController < Api::V1::BaseController
  before_action :set_city
  def index
    @teachers = @city.teachers
  end
  private
  def set_city
    @city = City.friendly.find(params[:city_id])
  end
end
