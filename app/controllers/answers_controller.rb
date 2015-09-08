require 'whatlanguage'

class AnswersController < ApplicationController
  include PostScope

  skip_after_action :verify_authorized, only: [ :preview, :language ]
  before_action :set_post, only: :create

  def preview
    @content = params[:content]
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
end
