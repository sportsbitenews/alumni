class Api::V1::BatchesController < Api::V1::BaseController
  def show
    @batch = Batch.find(params[:id])
  end
  def live
    @batch = Batch.where(live: true).order("slug DESC").first
  end
end
