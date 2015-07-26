class PostsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  before_action :set_post, only: :up_vote

  def index
    @posts = Resource.all + Question.all
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
