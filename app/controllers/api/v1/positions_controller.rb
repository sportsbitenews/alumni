class Api::V1::PositionsController < Api::V1::BaseController
  def index
    @positions = Position.includes(:user, :company).all
  end
end
