class Api::V1::BatchesController < Api::V1::BaseController
  def show
    if params.has_key?(:slug)
      @batch = Batch.includes(:users, projects: :users).find_by(slug: params[:id])
    else
      @batch = Batch.includes(:users, projects: :users).find(params[:id])
    end
  end

  def live
    @batch = Batch.where(live: true).order("slug DESC").first
  end

  def completed
    @batches = Batch.includes(:projects).where.not(youtube_id: [nil, ""])
    @batches += Batch.includes(:projects).where.not(id: @batches.map(&:id), projects: { id: nil }, slug: nil).where('starts_at < ?', Date.today)
    @batches = @batches.sort_by { |batch| batch.slug.to_i }
  end
end
