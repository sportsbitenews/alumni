require 'whatlanguage'

class AnswersController < ApplicationController
  include PostScope

  skip_before_filter :verify_authenticity_token, only: :update
  skip_after_action :verify_authorized, only: [ :preview, :language ]
  before_action :set_post, only: [:create]
  before_action :set_answer, only: [:update]
  respond_to :json, only: [:update]

  def preview
    @content = params[:content]
  end

  def update
    @answer.content = params[:content]
    @answer.save
  end

  def create
    answer = @post.answers.build user: current_user, content: params[:content]
    if !answer.save
      @post.answers.delete(answer)
    end
  end

  def language
    wl = WhatLanguage.new(:english, :french)
    render json: wl.process_text(params[:content])
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    authorize @answer
  end
end
