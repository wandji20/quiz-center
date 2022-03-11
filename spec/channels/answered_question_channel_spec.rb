require 'rails_helper'

RSpec.describe AnsweredQuestionChannel, type: :channel do
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

  let(:answered_question) do
    AnsweredQuestion.create(user_id: user.id, question_id: question.id)
  end
  before do
    stub_connection user_id: user.id
  end

  it 'subscribes with streams when no answered_question id' do
    subscribe(id: answered_question.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("answered_question_#{answered_question.id}")
  end

  it 'does not subscribe to a stream when answered question id is not provided' do
    subscribe(id: 'abc')
    expect(subscription).to_not have_stream_from("answered_question_#{answered_question.id}")
  end
end
