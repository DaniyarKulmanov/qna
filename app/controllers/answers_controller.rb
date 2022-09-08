# frozen_string_literal: true

class AnswersController < ApplicationController
  expose :question, -> { Question.find(params[:question_id]) }
  expose :answer, parent: :question

  def show; end

  def create
    if answer.save
      redirect_with 'Your answer successfully created'
    else
      redirect_with answer.errors.full_messages
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def redirect_with(notice)
    redirect_to question_path(question), notice: notice
  end
end
