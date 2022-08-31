require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes'
    it 'saves new answer to database'
    it 'redirects to show view'

    context 'with invalid attributes'
    it 'should not save answer with wrong attributes'
    it 're-renders new view'
  end
end
