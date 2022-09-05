# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able sign in
" do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit '/login'
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '1234678'

    expect(page).to have_content 'Signed in successfully'
  end
  scenario 'Unregistered user tries to sign in'
end
