# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves new question to database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:exposed_question))
        expect(flash[:notice]).to match('Your question successfully created')
      end
    end

    context 'with invalid attributes' do
      it 'should not save questions with wrong attributes' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question) }
    let!(:own_question) { create(:question, author: user) }

    before { login(user) }

    context "Delete some else's question" do
      it 'unable to delete' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(0)
        expect(flash[:notice]).to match('Only authored questions allowed for deletion')
      end

      it 'redirects back to questions' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'Delete own question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: own_question } }.to change(Question, :count).by(-1)
      end

      it 'redirects back to questions' do
        delete :destroy, params: { id: own_question }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
