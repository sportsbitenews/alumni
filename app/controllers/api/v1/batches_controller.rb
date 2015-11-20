class Api::V1::BatchesController < Api::V1::BaseController
  def show
    @batch = Batch.find(params[:id])
  end
  def live
    @batch = Batch.where(live: true).order("slug DESC").last
    @live_url = @batch ? batch_url(@batch) : nil
  end
end
