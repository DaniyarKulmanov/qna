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
      scenario 'question'
      scenario 'question with errors'
    end

    describe "tries edit other user's" do
      scenario 'question with errors'
    end
  end
end
