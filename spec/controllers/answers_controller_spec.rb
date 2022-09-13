# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:answer) { create(:answer) }
  let(:user) { create(:user) }

  before { login(user) }

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id } }.to change(Answer, :count).by(1)
      end
      it 'redirects to question show view with success notice' do
        post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id }
        expect(response).to redirect_to question_path(assigns(:exposed_question))
      end
    end

    context 'with invalid attributes' do
      it 'should not save answer with wrong attributes' do
        expect { post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id } }.to_not change(Answer, :count)
      end
      it 'redirects to question show view with errors' do
        post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id }
        expect(response).to redirect_to question_path(assigns(:exposed_question))
      end
    end
  end

  describe 'DELETE #destroy' do

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer, question_id: answer.question } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: answer, question_id: answer.question }
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
