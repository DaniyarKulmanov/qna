# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete only own question or answer', "
  In order to delete question or answer
  As authenticated user
  I'd like to be able delete only own question or answer
" do


  describe 'As authenticated user able to delete own', focus: true do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }
    given!(:answers) { create_list(:answer, 3, question: question, author: user) }

    scenario 'answer' do
      sign_in(user)
      visit question_path(question)

      question.answers.each do |answer|

        find("tr[id=#{answer.id}]").click_link('delete')
        expect(page).not_to have_content answer.body
      end
    end


    scenario 'question' do
      sign_in(user)
      visit questions_path

      find('tr', text: question.body).click_link('delete')
      expect(page).not_to have_content question.body
    end
  end

  describe "As authenticated user unable to delete someone else's", focus: true do
    given(:user) { create(:user) }
    given(:question) { create(:question) }
    given!(:answers) { create_list(:answer, 3, question: question) }

    scenario "answer" do
      sign_in(user)
      visit question_path(question)

      question.answers.each do |answer|
        find('tr', text: answer.body).click_link('delete')
        expect(page).to have_content 'Only authored answers allowed for deletion'
        expect(page).to have_content answer.body
      end
    end

    scenario 'question' do
      sign_in(user)
      visit questions_path

      find('tr', text: question.body).click_link('delete')
      expect(page).to have_content 'Only authored questions allowed for deletion'
      expect(page).to have_content question.body
    end
  end

  describe 'Unauthenticated user unable to delete' do
    given(:question) { create(:question) }
    given!(:answers) { create_list(:answer, 3, question: question) }

    scenario 'answer' do
      visit question_path(question)

      find('tr', text: question.answers.first.body).click_link('delete')

      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end

    scenario 'question' do
      visit questions_path

      find('tr', text: question.body).click_link('delete')

      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end
  end

end
