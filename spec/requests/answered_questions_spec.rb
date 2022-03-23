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
        answer_id: question.answers.last.id,
        quiz_id: quiz.id
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
  let(:answered_question) do
    AnsweredQuestion.create!(question_id: question.id, user_id: user.id, quiz: quiz)
  end

  describe 'POST /create' do
    context 'valid cattributes' do
      it 'returns http success' do
        post answered_questions_path, params: valid_attributes, headers: header, as: :json
        answered_question_id = AnsweredQuestion.last.id
        expect(response.body).to match(answered_question_id.to_s)
        expect(response).to have_http_status(:created)
      end
    end

    context 'already exist' do
      let(:attributes) do
        {
          answered_question: {
            question_id: question.id,
            quiz_id: quiz.id
          }
        }
      end
      it 'response with test OK' do
        answered_question
        post answered_questions_path, params: attributes, headers: header, as: :json
        expect(response.body).to match(/Ok/)
        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid cattributes' do
      it 'returns http 422 error' do
        post answered_questions_path,
             params: { answered_question: { quiz_id: quiz.id } },
             headers: header, as: :json
        expect(response.body).to match(/Question is required/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
