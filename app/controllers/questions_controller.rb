class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_question, only: [:show, :update, :solve]

  def show
    authorize @question
  end

  def create
    @question = current_user.questions.build question_params.except!(:authenticity_token)
    authorize @question
    if @question.save
      current_user.upvotes @question
      redirect_to question_path(@question)
    else
      render :'new'
    end
  end

  def update
    # TODO : handle title update
    @question.content = params[:content]
    @question.save
    authorize @question
  end

  def new
    @question = Question.new
    authorize @question
  end

  def solve
    @question.solved = !@question.solved
    @question.save
    authorize @question
    render json: {state: @question.solved}
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end
end

