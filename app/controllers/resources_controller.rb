class ResourcesController < ApplicationController
  skip_after_action :verify_authorized, only: :preview
  before_action :set_resource, only: :show
  skip_before_action :verify_authenticity_token, only: [:create]


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
      redirect_to resource_path(@resource)
    else
      render :'posts/new'
    end
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.permit(:url, :title, :tagline)
  end
end
