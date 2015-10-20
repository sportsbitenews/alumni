class Api::V1::BatchesController < Api::V1::BaseController
  def show
    @batch = Batch.find(params[:id])
  end
end
