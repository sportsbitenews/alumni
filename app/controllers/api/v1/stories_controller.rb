class Api::V1::StoriesController < Api::V1::BaseController
  def sample
    excluded_ids = (params[:excluded_ids] || "").split(',')
    limit = (params[:limit] || "").to_i

    @stories = Story.includes(:company).where(published: true).where.not(id: excluded_ids).limit(limit).order("RANDOM()")
    if @stories.size < limit
      @stories = Story.includes(:company).where(published: true).limit(limit).order("RANDOM()")
    end
    render :index
  end
  def index
    @stories_ordered_list = OrderedList.find_by_name('stories')
    if @stories_ordered_list
      @stories = Story.includes(:company).where(slug: @stories_ordered_list.slugs).sort_by do |story|
        @stories_ordered_list.slugs.index(story.slug)
      end
    else
      @stories = Story.includes(:company).order(created_at: :desc)
    end
  end
  def show
    unless @story = Story.find_by_slug(params[:id])
      render json: { errors: "no story found with slug #{params[:id]}" }, status: 404
    end
  end
end
