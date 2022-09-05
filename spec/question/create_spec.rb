# frozen_string_literal: true

require 'rails_helper'

feature 'User can create question', "
  In order to get answer from community
  As an authenticated user
  I'd like to be able ask the question
" do

  given(:user) { User.create!(email: 'user@test.com', password: '12345678') }

  background { visit new_user_session_path }

  scenario 'Authorized user asks question' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test text'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test text'
  end

  scenario 'Authorized user asks question with errors' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'

    click_on 'Ask'

    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Unauthorized user tries to ask question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content I18n.t('devise.failure.unauthenticated')
  end

end
