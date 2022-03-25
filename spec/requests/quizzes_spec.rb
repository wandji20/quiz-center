require 'rails_helper'

RSpec.describe 'Quizzes', type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }
  let(:header) { valid_headers(user.id) }

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
  describe 'GET /index' do
    it 'returns http success' do
      question
      get root_path, headers: header
      expect(response).to have_http_status(:success)
      expect(response.body).to match(quiz.title)
      expect(response.body).to match(user.email)
    end
  end
end
