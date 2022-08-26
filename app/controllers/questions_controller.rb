# frozen_string_literal: true

class QuestionsController < ApplicationController
  expose :question

  def show; end

  def create
    if question.save
      redirect_to question_path(question)
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
