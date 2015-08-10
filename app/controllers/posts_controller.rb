class PostsController < ApplicationController
  include PostScope
  skip_after_action :verify_policy_scoped, only: [:index]
  before_action :set_post, only: [:up_vote, :show]

  def index
    # TODO(ssaunier): sort by score
    # TODO(ssaunier): paginate
    # TODO(ssaunier): search
    @posts = {
      resources: Resource.all.includes(:user).sort_by(&:created_at).reverse,
      questions: Question.all.includes(:user).sort_by(&:created_at).reverse,
      jobs: Job.all.includes(:user).sort_by(&:created_at).reverse
    }
  end

  def up_vote
    if current_user.voted_for? @post
      current_user.unvote_for @post
    else
      current_user.up_votes @post
    end
  end
end
