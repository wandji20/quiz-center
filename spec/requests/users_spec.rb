require 'rails_helper'

RSpec.describe 'Users', type: :request do
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
  let(:answered_question) do
    AnsweredQuestion.create(
      quiz: quiz, user: user, answer: question.answers.last, question: question
    )
  end
  let(:valid_attributes) do
    {
      user: {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end

  let(:invalid_attributes) do
    {
      user: {
        email: Faker::Internet.email,
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end
  let(:user) { create(:user) }
  let(:header) { valid_headers(user.id) }
  describe 'POST /create' do
    context 'valid attributes' do
      it 'returns http success' do
        question
        post sign_up_path, params: valid_attributes, as: :json
        expect(response.body).to match(/Authorization/)
        expect(response).to have_http_status(:success)
        expect(response.body).to match(User.last.name)
        expect(response.body).to match(question.id.to_s)
      end
    end

    context 'invalid attributes' do
      it 'returns http bad request' do
        post sign_up_path, params: {}, as: :json
        expect(response.body).to match(/is missing or invalid/)
        expect(response).to have_http_status(400)
      end

      it 'returns http unprocessable entity' do
        post sign_up_path, params: invalid_attributes, as: :json
        expect(response.body).to match(/name can't be blank/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      answered_question
      get result_path, headers: header
      expect(response.body).to match(/score":1/)
      expect(response).to have_http_status(:success)
    end
  end
end
