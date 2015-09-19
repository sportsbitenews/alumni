class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :set_city
  def index
    @projects = params[:featured] ? @city.featured_projects : @city.projects
  end
  private
  def set_city
    @city = City.friendly.find(params[:city_id])
  end
end
