class Api::V1::PositionsController < Api::V1::BaseController
  def index
    @positions = Position.includes({user: :batch}, :company).all
  end
end
