# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Unauthenticated user can not edit or delete answer' do
    visit questions_path(question)

    expect(page).to_not have_link 'edit'
    expect(page).to_not have_link 'delete'
  end

  describe 'Authenticated user', js: true do
    describe 'edits his' do
      given!(:answer) { create(:answer, question: question, author: user) }

      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'answer' do
        within '.answers' do
          click_on 'edit'

          fill_in 'Your answer', with: 'edited answer'
          click_on 'save'

          expect(page).to_not have_content answer.body
          expect(page).to have_content 'edited answer'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'answer with errors' do
        within '.answers' do
          click_on 'edit'

          fill_in 'Your answer', with: ''
          click_on 'save'
        end
        expect(page).to have_content "Body can't be blank"
      end
    end

    describe "tries edit other user's" do
      given!(:answer) { create(:answer, question: question) }

      scenario 'answer with errors' do
        sign_in(user)
        visit question_path(question)

        within '.answers' do
          expect(page).to_not have_link 'edit'
        end
      end
    end

  end
end
