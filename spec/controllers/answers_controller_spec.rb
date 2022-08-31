# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:answer) { create(:answer) }

    context 'with valid attributes'
    it 'saves new answer to database' do
      expect { post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id } }.to change(Answer, :count).by(1)
    end
    it 'redirects to show view'

    context 'with invalid attributes'
    it 'should not save answer with wrong attributes'
    it 're-renders new view'
  end
end
