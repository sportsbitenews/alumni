class BatchesController < ApplicationController
  before_action :set_batch, only: [:show]
  def show
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
    authorize @batch
  end
end
