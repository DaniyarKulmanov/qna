# frozen_string_literal: true

require 'rails_helper'

feature 'User can give answer to a question', "
  In order to give answer to question
  As an authenticated user
  I'd like to be able answer to question
" do

  describe 'Authenticated user' do
    given(:user) { create(:user) }
    given(:question) { create(:question) }
    given(:answer) { create(:answer) }

    scenario 'Authenticated user tries answer to question' do
      sign_in(user)
      visit question_path(question)

      fill_in 'Body', with: answer.body
      check('Correct').set(answer.correct)
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content answer.body
      expect(page).to have_content answer.correct
    end

    scenario 'Authenticated user tries answer to question with errors'
  end

  scenario 'Unauthorized user tries answer to question'
end
