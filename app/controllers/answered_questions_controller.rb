class AnsweredQuestionsController < ApplicationController
  include Verification
  before_action :verify_answered_question_existence, only: :create

  api :POST, '/answered_questions', 'Initiate an answerd question'
  header :Authorization, 'Authentication token', required: true
  param :answered_question, Hash, 'Answered Question', required: true do
    param :question_id, Integer, desc: 'id of the question', required: true
    param :quiz_id, Integer, desc: 'id of the question', required: true
    param :answer_id, Integer, desc: 'id of the question'
  end

  def create
    payload = answered_question_params.merge(user: current_user)
    outcome = AnsweredQuestions::Create.run(payload)

    if outcome.valid?
      json_response({ answered_question_id: outcome.result.id }, :created)
    else
      json_response({ errors: outcome.errors.full_messages }, :unprocessable_entity)
    end
  end

  private

  def answered_question_params
    params.require(:answered_question).permit(:question_id, :answer_id, :quiz_id)
  end
end
