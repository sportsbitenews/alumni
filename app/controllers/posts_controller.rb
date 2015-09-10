class PostsController < ApplicationController
  include PostScope
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: :search
  before_action :set_post, only: [:up_vote, :show]

  def index
    # TODO(ssaunier): sort by score
    # TODO(ssaunier): paginate
    set_default_posts
  end

  def up_vote
    if current_user.voted_for? @post
      current_user.unvote_for @post
    else
      current_user.up_votes @post
    end
  end

  def search
    if params[:keywords].blank?
      set_default_posts
    else
      posts = Question.search(params[:keywords])  # Search 4 post types
      @posts = {
        resources: posts.select  { |r| r.is_a? Resource },
        questions: posts.select  { |r| r.is_a? Question },
        jobs: posts.select       { |r| r.is_a? Job },
        milestones: posts.select { |r| r.is_a? Milestone },
      }
    end
    render :index
  end

  private

  def set_default_posts
    @posts = {
      resources: Resource.all.includes(:user).sort_by(&:created_at).reverse,
      questions: Question.all.includes(:user).sort_by(&:created_at).reverse,
      jobs: Job.all.includes(:user).sort_by(&:created_at).reverse,
      milestones: Milestone.all.includes(:user).sort_by(&:created_at).reverse
    }
  end
end
