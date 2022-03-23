require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }

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
end
