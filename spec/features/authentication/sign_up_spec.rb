# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign up', "
  In order to get full functions
  As Unauthenticated user
  I'd like to be able sign up
" do

  given(:user) { create(:user) }

  background { visit new_user_registration_path }

  scenario 'Unregistered user tries to sign up' do
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end

  scenario 'Registered user tries to sign up'do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

end
