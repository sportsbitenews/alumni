class PostsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @posts = Resource.all + Question.all
  end
end
