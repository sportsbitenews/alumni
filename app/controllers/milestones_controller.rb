class MilestonesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_milestone, only: [:show]
  def new
    @milestone = Milestone.new
    authorize @milestone
  end

  def show
  end

  def update
    #TODO : handle all columns update
    @milestone.content = params[:content]
    @milestone.save
  end

  def create
    @milestone = current_user.milestones.build milestone_params.except!(:authenticity_token)
    authorize @milestone
    if @milestone.save
      current_user.upvotes @milestone
      redirect_to milestone_path(@milestone)
    else
      render :'new'
    end
  end

  private

  def set_milestone
    @milestone = Milestone.find(params[:id])
    authorize @milestone
  end

  def milestone_params
    params.require(:milestone).permit(
      :title,
      :content,
      :user_id,
      :project_id
    )
  end

end
