# frozen_string_literal: true

class AnswersController < ApplicationController
  expose :question, id: -> { params[:question_id] }
  expose :answer

  def show; end

  def create
    if answer.save
      redirect_to question_answer_path(answer)
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:answer).permit(:title, :correct, :body)
  end
end
