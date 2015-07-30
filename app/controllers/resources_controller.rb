class ResourcesController < ApplicationController
  skip_after_action :verify_authorized, only: :preview
  before_action :set_resource, only: :show

  def new
    @resource = Resource.new
    authorize @resource
  end

  def preview
    website = LinkThumbnailer.generate(params[:url])
    render json: website
  rescue Exception => e
    render json: { error: e.message }
  end

  def show
    authorize @resource
  end

  def create
    @resource = current_user.resources.build resource_params
    authorize @resource
    if @resource.save
      current_user.upvotes @resource
      redirect_to resources_path
    else
      render :new
    end
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:url, :title, :content)
  end
end
