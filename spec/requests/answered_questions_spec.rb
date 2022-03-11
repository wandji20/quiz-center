require 'rails_helper'

RSpec.describe 'AnsweredQuestions', type: :request do
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
      answered_question: {
        question_id: question.id,
        answer_id: question.answers.last.id
      }
    }
  end

  let(:invalid_attributes) do
    {
      answered_question: {
        question_id: question.id
      }
    }
  end

  let(:header) { valid_headers(user.id) }
  let(:answered_question) { AnsweredQuestion.create!(question_id: question.id, user_id: user.id) }

  describe 'POST /create' do
    context 'valid cattributes' do
      it 'returns http success' do
        post answered_questions_path, params: valid_attributes, headers: header, as: :json
        answered_question_id = AnsweredQuestion.last.id
        expect(response.body).to match(answered_question_id.to_s)
        expect(response).to have_http_status(:created)
      end
    end

    context 'invalid cattributes' do
      it 'returns http 422 error' do
        post answered_questions_path,
             params: { answered_question: { question_id: 'ao' } },
             headers: header, as: :json
        expect(response.body).to match(/Question must exist/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    context 'valid attributes' do
      it 'returns http success' do
        put answered_question_path(answered_question), params: valid_attributes, headers: header, as: :json
        expect(response.body).to match(/saved/)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid attributes' do
      it 'returns http bad request' do
        put answered_question_path(answered_question), params: {}, headers: header, as: :json
        expect(response.body).to match(/Answered question is missing or invalid/)
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns http unprocessable entity' do
        put answered_question_path(answered_question), params: invalid_attributes, headers: header, as: :json
        expect(response.body).to match(/valid question answer must be present/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'exceded time limit' do
      it 'returns http unprocessable entity' do
        answered_question.question.update(points: 0)
        sleep 1
        put answered_question_path(answered_question), params: valid_attributes, headers: header, as: :json
        expect(response.body).to match(/time limit exceeded/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
