class JobsController < ApplicationController
  before_action :set_job, only: [:show]
  def new
    @job = Job.new
    authorize @job
  end

  def create
    @job = current_user.jobs.build job_params.except!(:authenticity_token)
    authorize @job
    if @job.save
      current_user.upvotes @job
      redirect_to job_path(@job)
    else
      render :'new'
    end
  end

  def show
  end

  private

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def job_params
    params.permit(
      :company,
      :description,
      :contract,
      :remote,
      :title,
      :ad_url,
      :city,
      :contact_email,
      :authenticity_token
    )
  end
end
