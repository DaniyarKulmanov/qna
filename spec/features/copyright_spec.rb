# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete only own question or answer', "
  In order to delete question or answer
  As authenticated user
  I'd like to be able delete only own question or answer
" do

  describe 'As authenticated user able to delete own' do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }
    given!(:answers) { create_list(:answer, 3, question: question, author: user) }

    background do
      sign_in(user)
    end

    scenario 'answer' do
      visit question_path(question)

      question.answers.each do |answer|
        find("tr[id=#{answer.id}]").click_link('delete')
        expect(page).not_to have_content answer.body
      end
    end

    scenario 'question' do
      visit questions_path

      find('tr', text: question.body).click_link('delete')
      expect(page).not_to have_content question.body
    end
  end

  describe "As authenticated user unable to delete someone else's" do
    given(:user) { create(:user) }
    given(:question) { create(:question) }
    given!(:answers) { create_list(:answer, 3, question: question) }

    background do
      sign_in(user)
    end

    scenario 'answer' do
      visit question_path(question)

      question.answers.each do |answer|
        expect(page).to_not have_link 'delete'
        expect(page).to have_content answer.body
      end
    end

    scenario 'question' do
      visit questions_path

      expect(page).to_not have_link 'delete'
    end
  end

  describe 'Unauthenticated user unable to delete' do
    given(:question) { create(:question) }
    given!(:answers) { create_list(:answer, 3, question: question) }

    scenario 'answer' do
      visit question_path(question)

      expect(page).to_not have_link 'delete'
    end

    scenario 'question' do
      visit questions_path

      expect(page).to_not have_link 'delete'
    end
  end

end
