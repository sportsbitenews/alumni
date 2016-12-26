class ResourcesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_after_action :verify_authorized, only: :preview
  before_action :set_resource, only: :show

  def new
    @resource = Resource.new
    authorize @resource
  end

  def preview
    # website = LinkThumbnailer.generate(params[:url])
    render json: { }
  rescue Exception => e
    render json: { error: e.message }
  end

  def show
  end

  def create
    @resource = current_user.resources.build resource_params.except!(:authenticity_token)
    authorize @resource
    if @resource.save
      current_user.upvotes @resource
      redirect_to resource_path(@resource)
    else
      render :'new'
    end
  end

  private

  def without(*keys)
    cpy = self.dup
    keys.each { |key| cpy.delete(key) }
    cpy
  end

  def set_resource
    @resource = Resource.find(params[:id])
    authorize @resource
  end

  def resource_params
    params.require(:resource).permit(:url, :title, :tagline)
  end
end
