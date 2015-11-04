class Api::V1::StoriesController < Api::V1::BaseController
  def index
    excluded_ids = params[:excluded_ids].split(',')
    limit = params[:limit].to_i

    @stories = Story.includes(:company).where(published: true).where.not(id: excluded_ids).limit(limit).order("RANDOM()")
    if @stories.size < limit
      @stories = Story.includes(:company).where(published: true).limit(limit).order("RANDOM()")
    end
  end

  def show
    @story = Story.includes(:company).where(user_id: User.find_by_github_nickname(params[:id]).id).first
  end
end
