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

  def update
    batch = Batch.find_by_slug(params[:batch_slug])
    project_params = params.require(:project).permit!
    @project = Project.find_by_kitt_id(params[:id]) || Project.new(project_params)
    if @project.id
      if @project.update(project_params)
        render json: { msg: "project with kitt_id #{@project.kitt_id} updated" }, status: 200
      else
        render json:  { kitt_id: @project.kitt_id, error: @project.errors.full_messages }, status: 422
      end
    else
      @project.batch = batch
      @project.kitt_id = params[:id]
      params[:users_slugs].each do |slug|
        @project.users << User.find_by_slug(slug)
      end
      if @project.save
        render json: { msg: "project with kitt_id #{@project.kitt_id} created" }, status: 200
      else
        render json: { kitt_id: @project.kitt_id, error: @project.errors.full_messages }, status: 422
      end
    end
  end

  def positions
    projects_params = params.require(:projects)
    projects = []
    projects_params.map do |project_params|
      project = Project.find_by_kitt_id(project_params[:kitt_id])
      unless project.nil?
        project.set_list_position(project_params[:position].to_i)
      end
    end
    if projects.include? nil
      render json: { error: "one or more projects missing" }, status: 422
    else
      render json: { msg: "positions set" }, status: 200
    end
  end
end
