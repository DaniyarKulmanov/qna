# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let!(:answer) { create(:answer) }

    context 'with valid attributes' do
      it 'saves new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id } }.to change(Answer, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id }

        expect(response).to redirect_to question_answer_path(assigns(:exposed_question), assigns(:exposed_answer))
      end
    end

    context 'with invalid attributes' do
      it 'should not save answer with wrong attributes' do
        expect { post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id } }.to_not change(Answer, :count)
      end
      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id }
        expect(response).to render_template :new
      end
    end
  end
end
