class QuestionsController < ApplicationController
  before_action :set_question
  def show
    authorize @question
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end
