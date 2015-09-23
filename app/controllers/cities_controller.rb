class CitiesController < ApplicationController
  def index
    @cities = policy_scope(City).all
  end

  def show
    @city = City.friendly.find(params[:id])
    authorize @city
  end
end
