class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    if params[:city].present?
      city = City.friendly.find(params[:city])
      @projects = params[:featured] ? city.featured_projects : city.projects
    else
      @projects = params[:featured] ? Project.where(featured: true) : Project.all
    end
  end
end
