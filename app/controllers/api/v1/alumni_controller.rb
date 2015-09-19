class Api::V1::AlumniController < Api::V1::BaseController
  def index
    if params[:city]
      city = City.friendly.find(params[:city])
      @alumni = city.users.select(&:alumni)
    else
      @alumni = User.where(alumni: true)
    end
  end
end
