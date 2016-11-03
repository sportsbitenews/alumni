class Api::V1::BatchesController < Api::V1::BaseController
  def show
    @batch = Batch.find(params[:id])
  end

  def live
    @batch = Batch.where(live: true).order("slug DESC").first
  end

  def index
    @batches = Batch.includes(:projects).where.not(projects: { id: nil }).order(:slug)
  end
end
