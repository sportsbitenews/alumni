class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update]

  def index
    @cities = policy_scope(City)
  end

  def show
  end

  def edit
  end

  def update
    if @city.update(city_params)
      redirect_to city_path(@city)
    else
      render :edit
    end
  end

  def markdown_preview
    @content = params[:content]
    authorize(City)
  end

  private

  def set_city
    @city = City.friendly.find(params[:id])
    authorize @city
  end

  def city_params
    params.require(:city).permit(:logistic_specifics, :marketing_specifics)
  end
end
