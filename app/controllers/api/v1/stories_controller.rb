class Api::V1::StoriesController < Api::V1::BaseController
  def index
    @stories = Story.where(published: true)
  end
end
