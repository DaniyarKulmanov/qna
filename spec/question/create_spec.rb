# frozen_string_literal: true

require 'rails_helper'

feature 'User can create question', "
  In order to get answer from community
  As an authenticated user
  I'd like to be able ask the question
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do

    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks question' do
      fill_in 'Title', with: question.title
      fill_in 'Body', with: question.body
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

    scenario 'asks question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthorized user tries to ask question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

end
