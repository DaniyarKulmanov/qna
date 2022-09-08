# frozen_string_literal: true

require 'rails_helper'

feature 'Any user can view question and its answers', "
  In order to find answers for a question
  As any user
  I'd like to be able view questions and its answers
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  scenario 'Authenticated user can see question and its answers' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    question.answers do |answer|
      expect(page).to have_content answer.body
      expect(page).to have_content answer.correct
    end
  end

  scenario 'Unauthenticated user can see question and its answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    question.answers do |answer|
      expect(page).to have_content answer.body
      expect(page).to have_content answer.correct
    end
  end
end
