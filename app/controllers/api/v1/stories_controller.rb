class Api::V1::StoriesController < Api::V1::BaseController
  def index
    @stories = params[:published].present? ? Story.where(published: true) : Story.all
  end
end
