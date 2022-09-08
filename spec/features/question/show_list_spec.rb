# frozen_string_literal: true

require 'rails_helper'

feature 'User can see all questions', "
  In order get all questions from community
  As an unauthorized or authorized user
  I'd like to see all questions
" do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3) }

  scenario 'Unregistered user tries to see all questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  scenario 'Registered user tries to see all questions' do
    sign_in(user)
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
