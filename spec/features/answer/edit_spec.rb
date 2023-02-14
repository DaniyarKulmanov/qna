# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated user can not edit or delete answer' do
    visit questions_path(question)

    expect(page).to_not have_link 'edit'
    expect(page).to_not have_link 'delete'
  end

  describe 'Authenticated user' do
    scenario 'edits his answer', js: true do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        click_on 'edit'

        fill_in 'Your answer', with: 'edited answer'
        click_on 'save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors', js: true do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        click_on 'edit'

        fill_in 'Your answer', with: ''
        click_on 'save'
      end
      expect(page).to have_content "Body can't be blank"
    end

    scenario "tries to edit other user's question"
  end
end
