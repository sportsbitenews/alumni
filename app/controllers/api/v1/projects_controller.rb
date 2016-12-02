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
    project_params = params.require(:project).permit(
      :name, :url, :tagline_en, :tagline_fr, :cover_picture, technos: [])

    @project = Project.find_by_kitt_id(params[:id]) ||
                Project.find_by_slug(params[:project][:name].to_slug.normalize.to_s) ||
                Project.new
    @project.kitt_id = params[:id]
    @project.batch = batch

    @project.assign_attributes(project_params)

    new_project = !@project.persisted?

    if @project.save
      @project.users = []
      params[:user_github_nicknames].each do |github_nickname|
        user = User.find_by_github_nickname(github_nickname)
        @project.users << user if user
      end

      render json: { msg: "project #{new_project ? 'created' : 'updated'} with kitt_id #{@project.kitt_id}" }, status: 200
    else
      puts @project.errors.full_messages
      render json:  { kitt_id: @project.kitt_id, error: @project.errors.full_messages }, status: 422
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
