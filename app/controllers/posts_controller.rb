class PostsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  before_action :set_post, only: :up_vote

  def index
    # TODO(ssaunier): sort by score
    # TODO(ssaunier): paginate
    # TODO(ssaunier): search
    @posts = (Resource.all + Question.all).sort_by(&:created_at).reverse
  end

  def up_vote
    if current_user.voted_for? @post
      current_user.unvote_for @post
    else
      current_user.up_votes @post
    end
  end

  private

  def set_post
    fail UnauthorizedPostTypeException unless Post::POST_TYPES.include?(params[:type])
    @post = params[:type].constantize.find(params[:id])
    authorize @post
  end
end
