# frozen_string_literal: true

require 'rails_helper'

feature 'User can give answer to a question', "
  In order to give answer to question
  As an authenticated user
  I'd like to be able answer to question
" do

  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }
    given(:answer) { create(:answer) }

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'tries answer to question' do
      fill_in 'Body', with: answer.body
      check('Correct').set(answer.correct)
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content answer.body
      expect(page).to have_content answer.correct
      expect(current_path).to eq question_path(question)
    end

    scenario 'tries answer to question and see errors' do
      click_on 'Answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthorized user tries answer to question' do
    visit question_path(question)

    click_on 'Answer'
    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end
end
