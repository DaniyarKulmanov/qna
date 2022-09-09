# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete only own question or answer', "
  In order to delete question or answer
  As authenticated user
  I'd like to be able delete only own question or answer
" do


  describe 'Delete own' do
    scenario 'answer'
    scenario 'question'
  end

  describe "Delete someone else's" do
    scenario 'answer'
    scenario 'question'
  end

  describe 'Unauthenticated user unable to delete' do
    scenario 'answer'
    scenario 'question'
  end

end
