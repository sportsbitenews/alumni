class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create]

  def show
    authorize @question
  end

  def create
    @question = current_user.questions.build question_params
    authorize @question
    if @question.save
      current_user.upvotes @question
      redirect_to question_path(@question)
    else
      render :'posts/new'
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.permit(:title, :content)
  end
end

