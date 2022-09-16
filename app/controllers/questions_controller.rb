# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  expose :questions, -> { Question.all }
  expose :question

  def index
    questions
  end

  def show
    question
  end

  def create
    question.author = current_user

    if question.save
      redirect_to question_path(question), notice: 'Your question successfully created'
    else
      render :new
    end
  end

  def destroy
    if question.author == current_user
      question.destroy
      redirect_to questions_path
    else
      redirect_to questions_path, notice: 'Only authored questions allowed for deletion'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
