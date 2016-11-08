class Api::V1::BatchesController < Api::V1::BaseController
  def show
    @batch = Batch.includes(:users, projects: :users).find(params[:id])
  end

  def live
    @batch = Batch.where(live: true).order("slug DESC").first
  end

  def completed
    @batches = Batch.includes(:projects).where.not(projects: { id: nil }, slug: nil).where('starts_at < ?', Date.today).order(:slug)
  end
end
