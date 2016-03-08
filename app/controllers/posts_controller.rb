class PostsController < ApplicationController
  include PostScope
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: %i(search next)
  skip_before_action :authenticate_user!, only: %i(index search next)
  skip_after_action :verify_policy_scoped, only: [:index]
  before_action :set_post, only: [:up_vote, :show]

  def index
    # TODO(ssaunier): sort by score
    set_default_posts
  end

  def up_vote
    if current_user.voted_for? @post
      current_user.unvote_for @post
    else
      current_user.up_votes @post
      NotifyUpvoteInSlack.perform_later(@post.id, @post.class.to_s, current_user)
    end
  end

  def search
    if params[:keywords].blank?
      set_default_posts
    else
      posts = Question.includes(:answers, :user).search(params[:keywords])  # Search 4 post types
      @resources  = posts.select { |r| r.is_a? Resource }
      @questions  = posts.select { |r| r.is_a? Question }
      @jobs       = posts.select { |r| r.is_a? Job }
      @milestones = posts.select { |r| r.is_a? Milestone }
    end
    render :index
  end

  def next
    fail Post::UnauthorizedPostTypeException unless Post::POST_TYPES.include?(params[:type])
    @post_type = post_type
    @posts = post_type.list(page: params[:page])
  end

  private

  def set_default_posts
    @resources  = Resource.list
    @questions  = Question.list
    @jobs       = Job.list
    @milestones = Milestone.includes(:project).list
  end
end
