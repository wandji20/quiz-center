require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }
  let(:headers) { valid_headers(user.id) }
  let(:question) do
    Question.create!(quiz: quiz,
                     description: 'Which number is divisible by 2 and 3',
                     answers_attributes: [
                       { value: 1 },
                       { value: 2 },
                       { value: 3 },
                       { value: 4 },
                       { value: 6, is_correct: true }
                     ])
  end
  let(:valid_attributes) do
    {
      authentication: {
        email: user.email, password: user.password
      }
    }
  end

  let(:invalid_attributes) do
    {
      authentication: {
        email: user.email, password: 'some password'
      }
    }
  end
  describe 'POST /create' do
    context 'valid attributes' do
      it 'returns http success' do
        question
        post login_path, params: valid_attributes
        expect(response.body).to match(/Authorization/)
        expect(response.body).to match(user.username)
        expect(response.body).to match(question.id.to_s)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid attributes' do
      it 'returns http unprocessable entity' do
        post login_path, params: invalid_attributes
        expect(response.body).to match(/Invalid credentials/)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /show' do
    context 'valid attributes' do
      it 'returns http success' do
        question
        get home_path, headers: headers
        expect(response.body).to match(question.id.to_s)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid headers' do
      it 'returns http unprocessable entity' do
        question
        get home_path
        expect(response.body).to match(/Missing token/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
