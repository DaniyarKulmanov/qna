# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:answer) { create(:answer) }

  before { login(user) }

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id }, format: :js }.to change(Answer, :count).by(1)
      end
      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: answer.question.id }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do

      it 'should not save answer with wrong attributes' do
        expect { post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id }, format: :js }.to_not change(Answer, :count)
      end
      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer, :wrong), question_id: answer.question.id }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:own_answer) { create(:answer, author: user) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' }, question_id: answer.question }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' }, question_id: answer.question }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :wrong), question_id: answer.question }, format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :wrong), question_id: answer.question }, format: :js
        expect(response).to render_template :update
      end
    end

  end

  describe 'DELETE #destroy' do
    let!(:own_answer) { create(:answer, author: user) }

    context "Delete some else's answer" do
      it 'unable to delete' do
        expect { delete :destroy, params: { id: answer, question_id: answer.question } }.to change(Answer, :count).by(0)
        expect(flash[:notice]).to match('Only authored answers allowed for deletion')
      end

      it 'redirects back to question with notice' do
        delete :destroy, params: { id: answer, question_id: answer.question }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'Delete own answer' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: own_answer, question_id: own_answer.question } }.to change(Answer, :count).by(-1)
      end

      it 'redirects back to question' do
        delete :destroy, params: { id: own_answer, question_id: own_answer.question }
        expect(response).to redirect_to question_path(own_answer.question)
      end
    end
  end
end
