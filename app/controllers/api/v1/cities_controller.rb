class Api::V1::CitiesController < Api::V1::BaseController
  def index
    @cities = params[:active] ? City.where(active: true) : City.all
  end
  def show
    @city = City.friendly.find(params[:id])
  end
end
