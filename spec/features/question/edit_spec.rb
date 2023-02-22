# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his question', "
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
" do

  given!(:user) { create(:user) }

  scenario 'Unauthenticated user can not edit or delete question' do
    visit questions_path

    expect(page).to_not have_link 'edit'
    expect(page).to_not have_link 'delete'
  end

  describe 'Authenticated user', js: true do
    describe 'edits his' do
      given!(:question) { create(:question, author: user) }

      background do
        sign_in(user)
        visit questions_path
      end

      scenario 'question' do
        within '.questions' do
          click_on 'edit'

          fill_in 'Your question', with: 'changed body'
          click_on 'save'
        end

        expect(page).to_not have_content question.body
        expect(page).to have_content 'changed body'
        expect(page).to_not have_selector 'textarea'
      end

      scenario 'question with errors' do
        within '.questions' do
          click_on 'edit'

          fill_in 'Your title', with: ''
          fill_in 'Your question', with: ''
          click_on 'save'
        end

        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Body can't be blank"
      end
    end

    describe "tries edit other user's" do
      scenario 'question'
    end
  end
end
