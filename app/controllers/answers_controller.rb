# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :create
  before_action :set_answer, only: %i[edit update destroy]

  def create
    @answer = @question.answers.create(answer_params)
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      redirect_to question_path(question)
    else
      redirect_with 'Only authored answers allowed for deletion'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def redirect_with(notice)
    redirect_to question_path(question), notice: notice
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
