class Api::V1::StoriesController < Api::V1::BaseController
  def index
    @stories = params[:published] ? Story.where(published: true) : Story.all
  end
end
