# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign out', "
  In order to safely exit app
  As an authenticated user
  I'd like to be able sign out
" do

  given(:user) { create(:user) }

  background { visit root_path }

  scenario 'Authenticated user tries sign out' do
    sign_in(user)

    click_on 'log out'

    expect(page).to have_content 'Signed out successfully'
    expect(page).to have_content 'log in'
    expect(page).to have_content 'sign up'
    expect(page).not_to have_content 'log out'

  end

  scenario 'Unauthenticated user tries sign out' do
    expect(page).to have_content 'log in'
    expect(page).to have_content 'sign up'
    expect(page).not_to have_content 'log out'
  end
end
