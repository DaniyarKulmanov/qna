# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  expose :question, -> { Question.find(params[:question_id]) }
  expose :answer, parent: :question

  def create
    answer.author = current_user

    if answer.save
      redirect_with 'Your answer successfully created'
    else
      redirect_with answer.errors.full_messages
    end
  end

  def destroy
    if answer.author == current_user
      answer.destroy
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

  def build_params
    @answer = Answer.new(answer_params)
    @answer.author = current_user
    @answer
  end
end
