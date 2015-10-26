class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    if params[:city].present?
      @projects = City.friendly.find(params[:city]).projects
    elsif params[:list_name].present?
      list = OrderedList.find_by_name(params[:list_name])
      if list
        @projects = Project.where(slug: list.slugs).sort_by {|p| list.slugs.index(p.slug) }
      else
        @projects = Project.all
      end
    else
      @projects = Project.all
    end
  end
end
