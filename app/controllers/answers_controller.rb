class AnswersController < ApplicationController
  include PostScope

  skip_after_action :verify_authorized, only: :preview
  before_action :set_post, only: :create

  def preview
    @content = params[:content]
  end

  def create
    answer = @post.answers.build user: current_user, content: params[:content]
    answer.save
  end
end