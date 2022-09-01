# frozen_string_literal: true

class AnswersController < ApplicationController
  expose :question, -> { Question.find(params[:question_id]) }
  expose :answer, parent: :question

  def show; end

  def create
    if answer.save
      redirect_to question_answer_path(question, answer)
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :correct, :body)
  end
end
