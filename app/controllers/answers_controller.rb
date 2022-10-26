# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :create
  before_action :set_answer, only: %i[edit update destroy]

  def create
    @answer = @question.answers.create(answer_params)
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      render :edit
    end
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      redirect_to question_path(@answer.question)
    else
      redirect_to question_path(@answer.question), notice: 'Only authored answers allowed for deletion'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
