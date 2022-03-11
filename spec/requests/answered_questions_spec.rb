require 'rails_helper'

RSpec.describe "AnsweredQuestions", type: :request do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }

  let(:question) { Question.create!( quiz: quiz, 
      description: 'Which number is divisible by 2 and 3',
      answers_attributes: [
        { value: 1 },
        { value: 2 },
        { value: 3 },
        { value: 6, is_correct: true },
        { value: 4 }
      ]
    )
  }

  let(:valid_attributes) do
    {
      answered_question: {
        question_id: question.id
      }
    }
  end

  let(:invalid_attributes) do
    {
      answered_question: {
        question_id: 'test'
      }
    }
  end

  let(:header) { valid_headers(user.id) }

  describe "POST /create" do
    context 'valid cattributes' do
      it "returns http success" do
        post answered_questions_path, params: valid_attributes, headers: header, as: :json
        expect(response.body).to match(/timer started/)
        expect(response).to have_http_status(:created)
      end
    end

    context 'invalid cattributes' do
      it "returns http 422 error" do
        post answered_questions_path, params: invalid_attributes, headers: header, as: :json
        expect(response.body).to match(/Question must exist/)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "PUT /update" do
  #   it "returns http success" do
  #     put answered_question_path(question), params: valid_attributes
  #     expect(response.body).to match(/some text/)
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
