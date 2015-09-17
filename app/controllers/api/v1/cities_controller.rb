class Api::V1::CitiesController < Api::V1::BaseController
  def index
    @cities = City.where(active: true)
  end
  def show
    @city = City.friendly.find(params[:id])
  end
end
